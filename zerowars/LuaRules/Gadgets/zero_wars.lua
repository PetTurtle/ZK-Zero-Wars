if (not gadgetHandler:IsSyncedCode()) then return false end

function gadget:GetInfo()
    return {
        name = "Zero_Wars",
        desc = "zero-wars, need 1 and only 1 inactive ai on both teams to work",
        author = "petturtle",
        date = "2020",
        license = "GPL",
        layer = 3,
        enabled = true,
        handler = true
    }
end

local setDataTime = 5
local spawnTime = 800
local updateTime = 60

local dataSet = false
local team1
local team2
local leftSide
local rightSide
local waves = {}
local artyWave = {}

local spGameOver = Spring.GameOver
local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGetUnitStates = Spring.GetUnitStates
local spGetUnitHealth = Spring.GetUnitHealth
local spGetUnitAllyTeam = Spring.GetUnitAllyTeam
local spGetUnityDefID = Spring.GetUnitDefID
local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitsInRectangle = Spring.GetUnitsInRectangle
local spGetUnitIsDead = Spring.GetUnitIsDead
local spDestroyUnit = Spring.DestroyUnit
local spGetTeamList = Spring.GetTeamList
local spGetTeamInfo = Spring.GetTeamInfo
local spGetTeamLuaAI = Spring.GetTeamLuaAI

include("LuaRules/Configs/customcmds.h.lua")

function Rect(x1, y1, x2, y2)
    local rect = {
        x1 = x1,
        y1 = y1,
        x2 = x2,
        y2 = y2
    }
    return rect
end

function Wave(units, spawnFrame)
    local wave = {
        units = units,
        spawnFrame = spawnFrame
    }
    return wave
end

function Team(nullAi)
	local allyTeam = select(6, spGetTeamInfo(nullAi, false))
	local teamList = spGetTeamList(allyTeam)
    for i = 1, #teamList do
        if (teamList[i] == nullAi) then
            table.remove(teamList, i)
        end
    end
	local team = {
		nullAi = nullAi,
		allyTeam = allyTeam,
		teamList = teamList
	}
	return team
end

function Platform(rect, buildingRect, offsetX, offsetY, attackXPos)
	local platform = {
        rect = rect,
        buildingRect = buildingRect,
        offsetX = offsetX,
        offsetY = offsetY,
        attackXPos = attackXPos,
        enabled = false
	}
	return platform
end

function Side(team, plats, baseId, turretId)
    local side = {
        team = team,
        plats = plats,
        baseId = baseId,
        turretId = turretId,
        iterator = 0
    }
    return side
end

local function GetTeamIsNull(teamID)
    local luaAI = spGetTeamLuaAI(teamID)
    if luaAI and string.find(string.lower(luaAI), "ai") then return true end
    return false
end

local function DeployTeam(plat, team, units, frame)
    local spawnedUnits = {}
    local spawnedArty = {}
    for i = 1, #units do
        local unitDefID = spGetUnityDefID(units[i])
        local x, y, z = spGetUnitPosition(units[i])
        local states = spGetUnitStates(units[i])
        local isValidUnit = true
        local buildProgress = select(5, spGetUnitHealth(units[i]))
        local ud = UnitDefs[unitDefID]
        if ud.isImmobile or buildProgress < 1 then --ud.canFly
             isValidUnit = false 
        end

        if ud.customParams.commtype then
            isValidUnit = false
            Spring.SetUnitPosition(units[i], x + plat.offsetX, z + plat.offsetY)
        end

        if isValidUnit then
            local unit = Spring.CreateUnit(unitDefID, x + plat.offsetX, 150, z + plat.offsetY, "n", team.nullAi)
            if (ud.maxWeaponRange >= 600) then
                table.insert(spawnedArty, unit)
            else
                table.insert(spawnedUnits, unit)
            end
            
            if (ud.maxWeaponRange >= 400 and ud.weapons[1].onlyTargets.land) then
                spGiveOrderToUnit(unit, CMD_UNIT_AI, {0}, {})
            end
			spGiveOrderToUnit(unit, CMD.FIRE_STATE, {states["firestate"]}, 0) -- {2}
            spGiveOrderToUnit(unit, CMD.MOVE_STATE, {states["movestate"]}, 0) -- {0}
            if states["movestate"] == 0 then
                spGiveOrderToUnit(unit, CMD_UNIT_AI, {0}, {})
                spGiveOrderToUnit(unit, CMD.INSERT, {-1, CMD.FIGHT, CMD.OPT_SHIFT, x + plat.attackXPos, 0, z + plat.offsetY}, {"alt"});
            elseif states["movestate"] == 1 then
                spGiveOrderToUnit(unit, CMD.INSERT, {-1, CMD.FIGHT, CMD.OPT_SHIFT, x + plat.attackXPos, 0, z + plat.offsetY}, {"alt"});
            else
                spGiveOrderToUnit(unit, CMD.INSERT, {-1, CMD.FIGHT, CMD.OPT_SHIFT, x + plat.attackXPos, 0, z + plat.offsetY}, {"alt"});
            end
        end
    end
    if #spawnedUnits > 0 then
        table.insert(waves, Wave(spawnedUnits, frame))
    end
    if #spawnedArty > 0 then
        table.insert(artyWave, Wave(spawnedArty, frame))
    end
end

local function DeployPlatform(plat, team, frame)
    for i = 1, #team.teamList do
        local units = spGetUnitsInRectangle(plat.rect.x1, plat.rect.y1, plat.rect.x2, plat.rect.y2, team.teamList[i])
        if #units > 0 then
            DeployTeam(plat, team, units, frame)
        end
    end
end

local function DeploySide(side, frame)
    DeployPlatform(side.plats[side.iterator + 1], side.team, frame)
    side.iterator = ((side.iterator + 1) % #side.plats)
end

local function hasUnitsInRect(team, rect)
    local hasUnits = false
    for i = 1, #team.teamList do
        local units = spGetUnitsInRectangle(rect.x1, rect.y1, rect.x2, rect.y2, team.teamList[i])
        if #units > 0 then
            hasUnits = true
            break
        end
    end
    return hasUnits
end

local function SetLeftSide(team)
    -- Set Turrets
    local baseId = Spring.CreateUnit("turretheavylaser", 2175, 10000, 1530, "n", team.nullAi)
    local turretId = Spring.CreateUnit("turretriot", 3200, 10000, 1530, "n", team.nullAi)
    local chainSaw = Spring.CreateUnit("turretaafar", 800, 10000, 1530, "n", team.nullAi)
    Spring.SetUnitMaxHealth(baseId, 5000)
    Spring.SetUnitHealth(baseId, 5000)
    Spring.SetUnitMaxHealth(turretId, 3500)
    Spring.SetUnitHealth(turretId, 3500)
    Spring.SetUnitWeaponState(baseId, 1, "reloadTime", 1.0)
    Spring.SetUnitWeaponState(turretId, 1, "projectiles", 2)
    Spring.SetUnitWeaponState(chainSaw, 1, "projectiles", 2)

    -- Set platform data
    local platformTop    = Platform(Rect(384, 0,    760,  760), Rect(0, 0,    384,  760), 1280,  1144, 5500)
    local platformCenter = Platform(Rect(384, 1152, 760, 1912), Rect(0, 1152, 384, 1912), 1280,  0,    5500)
    local platformBottom = Platform(Rect(384, 2304, 760, 3064), Rect(0, 2304, 384, 3064), 1280, -1144, 5500)
    local plats = {platformTop, platformCenter, platformBottom}

    -- Remove Unused platform, if more then 2 players, no platforms removed
    local remPlat = 3 - #team.teamList
    for i = #plats, 1, -1 do
        local hasUnits = hasUnitsInRect(team, plats[i].buildingRect)
        if (hasUnits == false and remPlat > 0) then
            table.remove(plats, i)
            remPlat = remPlat - 1
        end
    end

    -- Deploy mex and razer on active sides
    for i = 1, #plats do
        local bRect = plats[i].buildingRect
        Spring.CreateUnit("staticmex", bRect.x1 + 23, 10000, bRect.y1 + 290, "n", team.nullAi)
        Spring.CreateUnit("staticmex", bRect.x1 + 23, 10000, bRect.y1 + 487, "n", team.nullAi)
        local aa = Spring.CreateUnit("turretaaflak", bRect.x1 + 364, 10000, bRect.y1 + 380, "n", team.nullAi)
        Spring.SetUnitWeaponState(aa, 1, "projectiles", 100)
    end

    -- Set side Data
    leftSide = Side(team, plats, baseId, turretId)

    -- Clear Team start resources
    Spring.SetTeamResource(team.nullAi, "metal", 0)
    for i = 1, #team.teamList do
        Spring.SetTeamResource(team.teamList[i], "metal", 0)
    end

    -- Remove nullai com
    local nullAICom = spGetUnitsInRectangle(0, 1530, 5, 1535, team.nullAi)
    spDestroyUnit(nullAICom[1], false, true)
end

local function SetRightSide(team)
    -- Set Turrets
    local baseId = Spring.CreateUnit("turretheavylaser", 6017, 10000, 1530, "n", team.nullAi)
    local turretId = Spring.CreateUnit("turretriot", 4992, 10000, 1530, "n", team.nullAi)
    local chainSaw = Spring.CreateUnit("turretaafar", 7392, 10000, 1530, "n", team.nullAi)
    Spring.SetUnitMaxHealth(baseId, 5000)
    Spring.SetUnitHealth(baseId, 5000)
    Spring.SetUnitMaxHealth(turretId, 3500)
    Spring.SetUnitHealth(turretId, 3500)
    Spring.SetUnitWeaponState(baseId, 1, "reloadTime", 1.0)
    Spring.SetUnitWeaponState(turretId, 1, "projectiles", 2)
    Spring.SetUnitWeaponState(chainSaw, 1, "projectiles", 2)

    -- Set platform data
    local platformTop    = Platform(Rect(7432,    0, 7808,  760), Rect(7808,    0, 8192,  760), -1280,  1144, -5500)
    local platformCenter = Platform(Rect(7432, 1152, 7808, 1912), Rect(7808, 1152, 8192, 1912), -1280,  0,    -5500)
    local platformBottom = Platform(Rect(7432, 2304, 7808, 3064), Rect(7808, 2304, 8192, 3064), -1280, -1144, -5500)
    local plats = {platformTop, platformCenter, platformBottom}
    
    -- Remove Unused platform, if more then 2 players, no platforms removed
    local remPlat = 3 - #team.teamList
    for i = #plats, 1, -1 do
        local hasUnits = hasUnitsInRect(team, plats[i].buildingRect)
        if (hasUnits == false and remPlat > 0) then
            table.remove(plats, i)
            remPlat = remPlat - 1
        end
    end

    -- Deploy mex and razer on active sides
    for i = 1, #plats do
        local bRect = plats[i].buildingRect
        Spring.CreateUnit("staticmex", bRect.x2 - 23, 10000, bRect.y1 + 290, "n", team.nullAi)
        Spring.CreateUnit("staticmex", bRect.x2 - 23, 10000, bRect.y1 + 487, "n", team.nullAi)
        local aa = Spring.CreateUnit("turretaaflak", bRect.x2 - 364, 10000, bRect.y1 + 380, "n", team.nullAi)
        Spring.SetUnitWeaponState(aa, 1, "projectiles", 100)
    end
    
    -- Set side Data
    rightSide = Side(team, plats, baseId, turretId)

    -- Clear Team start resources
    Spring.SetTeamResource(team.nullAi, "metal", 0)
    for i = 1, #team.teamList do
        Spring.SetTeamResource(team.teamList[i], "metal", 0)
    end

    -- Remove nullai com
    local nullAICom = spGetUnitsInRectangle(8190, 1530, 8192, 1535, team.nullAi)
    spDestroyUnit(nullAICom[1], false, true)
end

local function SetSides()
    local units = spGetUnitsInRectangle(0, 0, 384, 3064)
    local unitAllyTeam = spGetUnitAllyTeam(units[1])
    if unitAllyTeam == team1.allyTeam then
        SetLeftSide(team1)
        SetRightSide(team2)
    else
        SetLeftSide(team2)
        SetRightSide(team1)
    end
end

function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end

	-- Get AI team id
	local teams = spGetTeamList()
	local nullTeam1 = -1;
	local nullTeam2 = -1;
    for i = 1, #teams do
        if GetTeamIsNull(teams[i]) then
            if nullTeam1 == -1 then
                nullTeam1 = teams[i]
            else
                nullTeam2 = teams[i]
            end
        end
    end
	team1 = Team(nullTeam1)
    team2 = Team(nullTeam2)
end

function gadget:GameFrame(f)
    if f == setDataTime then
        SetSides()
        dataSet = true
	end

    -- Deploy Each side
    if f > 0 and f % spawnTime == 0 then
        DeploySide(leftSide, f)
        DeploySide(rightSide, f)
    end

    -- Despawn old wave
    local units
    if f > 0 and f % updateTime == 0 then
        if #waves > 0 and waves[1].spawnFrame + 4500 < f  then
            units = waves[1].units
            for j = 1, #units do
                if not spGetUnitIsDead(units[j]) then
                    spDestroyUnit(units[j])
                end
            end
            table.remove(waves, 1)
        end
        if #artyWave > 0 and artyWave[1].spawnFrame + 2500 < f then
            units = artyWave[1].units
            for j = 1, #units do
                if not spGetUnitIsDead(units[j]) then
                    spDestroyUnit(units[j])
                end
            end
            table.remove(artyWave, 1)
        end
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerID, attackerDefID, attackerTeam)
    if dataSet then
        if unitID == leftSide.baseId then
            spGameOver({rightSide.team.allyTeam})
        elseif unitID == rightSide.baseId then
            spGameOver({leftSide.team.allyTeam})
        elseif unitID == leftSide.turretId then
            for i = 1, #rightSide.team.teamList do
                Spring.AddTeamResource(rightSide.team.teamList[i], "metal", 800)
            end
        elseif unitID == rightSide.turretId then
            for i = 1, #leftSide.team.teamList do
                Spring.AddTeamResource(leftSide.team.teamList[i], "metal", 800)
            end
        end
    end
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)

end

function gadget:AllowFeatureCreation(featureDefID, teamID, x, y, z)
    return false
end

