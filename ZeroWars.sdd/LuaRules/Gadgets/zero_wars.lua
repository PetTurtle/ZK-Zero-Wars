if not gadgetHandler:IsSyncedCode() then return false end

function gadget:GetInfo()
    return {
        name = "Zero Wars",
        desc = "zero wars",
        author = "petturtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 3,
        enabled = true,
        handler = true
    }
end

local dataSet = false
local pBorder = 20 -- platform border

local leftTeam
local rightTeam
local leftSide
local rightSide

local spawnTime = 100 -- #frames between waves
local updateTime = 60
local waves = {}
local artyWave = {}

local GiveClampedOrderToUnit = Spring.Utilities.GiveClampedOrderToUnit

----- Initalizing Game -----

function Rect(x1, y1, x2, y2)
    local rect = {
        x1 = x1,
        y1 = y1,
        x2 = x2,
        y2 = y2
    }
    return rect
end

-- Create team, holds all team related data for each side
function CreateTeam(nullAI)
    local allyTeam = select(6, Spring.GetTeamInfo(nullAI, false))
    local playerList = Spring.GetTeamList(allyTeam)

    -- remove nullAI from player list
    for i = 1, #playerList do
        if (playerList[i] == nullAI) then
            table.remove(playerList, i)
        end
    end

	local team = {
		nullAI = nullAI,
		allyTeam = allyTeam,
		playerList = playerList
    }
	return team
end

function CreatePlatform(rect, deployRect, offsetX, offsetY, attackXPos)
	local platform = {
        rect = rect,
        deployRect = deployRect,
        offsetX = offsetX,
        offsetY = offsetY,
        attackXPos = attackXPos,
        players = {}
	}
	return platform
end

function CreateSide(team, plats)
    local side = {
        team = team,
        plats = plats,
        baseId = -1,
        turretId = -1,
        iterator = 0
    }
    return side
end

-- Sets left side data on initialize
local function InitializeLeftSide()

    -- Set platform data
    local platformTop    = CreatePlatform(Rect(0, 0, 760, 760), Rect(384, 0, 760, 760), 1280, 1144, 5888)
    local platformCenter = CreatePlatform(Rect(0, 1152, 760, 1912), Rect(384, 1152, 760, 1912), 1280, 0, 5888)
    local platformBottom = CreatePlatform(Rect(0, 2304, 760, 3064), Rect(384, 2304, 760, 3064), 1280, -1144, 5888)
    local plats = {platformTop, platformCenter, platformBottom}
    
    for i = 1, #leftTeam.playerList do
        table.insert(plats[(i%3)+1].players, leftTeam.playerList[i])
    end

    -- Remove unused platforms
    for i = #plats, 1, -1 do
        if #plats[i].players == 0 then
            local function RemovePlatform()
                local rect = plats[i].rect
                for x = rect.x1 - pBorder, rect.x2 + pBorder, 1 do
                    for z = rect.y1 - pBorder, rect.y2 + pBorder, 1 do
                        Spring.SetHeightMap(x, z, -25)
                    end
                end
            end
            Spring.SetHeightMapFunc(RemovePlatform)
            table.remove(plats, i)
        end
    end

    leftSide = CreateSide(leftTeam, plats)
end

-- Sets right side data on initialize
local function InitializeRightSide()

    -- Set platform data
    local platformTop    = CreatePlatform(Rect(7432,    0, 8192,  760), Rect(7432,    0, 7808,  760), -1280,  1144, 2303)
    local platformCenter = CreatePlatform(Rect(7432, 1152, 8192, 1912), Rect(7432, 1152, 7808, 1912), -1280,  0,    2303)
    local platformBottom = CreatePlatform(Rect(7432, 2304, 8192, 3064), Rect(7432, 2304, 7808, 3064), -1280, -1144, 2303)
    local plats = {platformTop, platformCenter, platformBottom}

    for i = 1, #rightTeam.playerList do
        table.insert(plats[(i%3)+1].players, rightTeam.playerList[i])
    end

    -- Remove unused platforms
    for i = #plats, 1, -1 do
        if #plats[i].players == 0 then

            local function RemovePlatform()
                local rect = plats[i].rect
                for x = rect.x1 - pBorder, rect.x2 + pBorder, 1 do
                    for z = rect.y1 - pBorder, rect.y2 + pBorder, 1 do
                        Spring.SetHeightMap(x, z, -25)
                    end
                end
            end
            Spring.SetHeightMapFunc(RemovePlatform)
            table.remove(plats, i)
        end
    end

    rightSide = CreateSide(rightTeam, plats)
end

-- Sets left side data on first frame
local function CreateLeftSide()
    local baseId = Spring.CreateUnit("turretheavylaser", 2303, 10000, 1530, "e", leftTeam.nullAI)
    local turretId = Spring.CreateUnit("turretriot", 3264, 10000, 1530, "e", leftTeam.nullAI)
    Spring.SetUnitMaxHealth(baseId, 5000)
    Spring.SetUnitHealth(baseId, 5000)
    Spring.SetUnitMaxHealth(turretId, 3500)
    Spring.SetUnitHealth(turretId, 3500)
    Spring.SetUnitWeaponState(baseId, 1, "reloadTime", 1.0)
    Spring.SetUnitWeaponState(turretId, 1, "projectiles", 2)
    leftSide.baseId = baseId
    leftSide.turretId = turretId

    for i = 1, #leftSide.plats do
        for t = 1, #leftSide.plats[i].players do
            local units = Spring.GetTeamUnits(leftSide.plats[i].players[t])
            Spring.SetUnitPosition(units[1], leftSide.plats[i].rect.x1, leftSide.plats[i].rect.y1 + 350)
            local aa = Spring.CreateUnit("turretaaflak", leftSide.plats[i].rect.x1 + 364, 10000, leftSide.plats[i].rect.y1 + 380, "n", leftTeam.nullAI)
            Spring.SetUnitWeaponState(aa, 1, "projectiles", 100)
        end
    end

    Spring.SetTeamResource(leftTeam.nullAI, "metal", 0)
    for i = 1, #leftTeam.playerList do
        Spring.SetTeamResource(leftTeam.playerList[i], "metal", 0)
    end

    local nullAICom = Spring.GetUnitsInRectangle(3968, 1152, 4224, 1920, leftTeam.nullAI)
    Spring.DestroyUnit(nullAICom[1], false, true)
end

-- Sets right side data on first frame
local function CreateRightSide()
    local baseId = Spring.CreateUnit("turretheavylaser", 5888, 10000, 1530, "w", rightTeam.nullAI)
    local turretId = Spring.CreateUnit("turretriot", 4930, 10000, 1530, "w", rightTeam.nullAI)
    Spring.SetUnitMaxHealth(baseId, 5000)
    Spring.SetUnitHealth(baseId, 5000)
    Spring.SetUnitMaxHealth(turretId, 3500)
    Spring.SetUnitHealth(turretId, 3500)
    Spring.SetUnitWeaponState(baseId, 1, "reloadTime", 1.0)
    Spring.SetUnitWeaponState(turretId, 1, "projectiles", 2)
    rightSide.baseId = baseId
    rightSide.turretId = turretId

    for i = 1, #rightSide.plats do
        for t = 1, #rightSide.plats[i].players do
            local units = Spring.GetTeamUnits(rightSide.plats[i].players[t])
            Spring.SetUnitPosition(units[1], rightSide.plats[i].rect.x2, rightSide.plats[i].rect.y2 - 350)
            local aa = Spring.CreateUnit("turretaaflak", rightSide.plats[i].rect.x2 - 364, 10000, rightSide.plats[i].rect.y1 + 370, "n", rightTeam.nullAI)
            Spring.SetUnitWeaponState(aa, 1, "projectiles", 100)
        end
    end

    Spring.SetTeamResource(rightTeam.nullAI, "metal", 0)
    for i = 1, #rightTeam.playerList do
        Spring.SetTeamResource(rightTeam.playerList[i], "metal", 0)
    end

    local nullAICom = Spring.GetUnitsInRectangle(3968, 1152, 4224, 1920, rightTeam.nullAI)
    Spring.DestroyUnit(nullAICom[1], false, true)
end

----- Spawning Waves -----

function NewWave(units, spawnFrame)
    local wave = {
        units = units,
        spawnFrame = spawnFrame
    }
    return wave
end

local function DeployWave(plat, units, nullAI, frame, faceDir)
    local spawnedUnits = {}
    local spawnedArty = {}
    for i = 1, #units do
        local unitDefID = Spring.GetUnitDefID(units[i])
        local x, y, z = Spring.GetUnitPosition(units[i])
        local states = Spring.GetUnitStates(units[i])
        local buildProgress = select(5, Spring.GetUnitHealth(units[i]))
        local ud = UnitDefs[unitDefID]
        if ud.customParams.commtype then
            isValidUnit = false
            Spring.SetUnitPosition(units[i], x + plat.offsetX, z + plat.offsetY)
        elseif not ud.isImmobile and buildProgress == 1  then
            local unit = Spring.CreateUnit(unitDefID, x + plat.offsetX, 150, z + plat.offsetY, faceDir, nullAI)
            if (ud.maxWeaponRange >= 600) then
                table.insert(spawnedArty, unit)
            else
                table.insert(spawnedUnits, unit)
            end
            Spring.GiveOrderToUnit(unit, CMD.FIRE_STATE, {states["firestate"]}, 0)
            Spring.GiveOrderToUnit(unit, CMD.MOVE_STATE, {states["movestate"]}, 0)
            --Spring.GiveOrderToUnit(unit, CMD.INSERT, {-1, CMD.FIGHT, CMD.OPT_SHIFT, plat.attackXPos, 0, z + plat.offsetY}, {"alt"});
            Spring.GiveOrderToUnit(unit, CMD.FIGHT, {plat.attackXPos, 0, z + plat.offsetY}, 0)
        end
    end
    if #spawnedUnits > 0 then
        table.insert(waves, NewWave(spawnedUnits, frame))
    end
    if #spawnedArty > 0 then
        table.insert(artyWave, NewWave(spawnedArty, frame))
    end
end

local function DeployPlatform(plat, nullAI, frame, faceDir)
    for i = 1, #plat.players do
        local units = Spring.GetUnitsInRectangle(plat.deployRect.x1, plat.deployRect.y1, plat.deployRect.x2, plat.deployRect.y2, plat.players[i])
        if #units > 0 then
            DeployWave(plat, units, nullAI, frame, faceDir)
        end
    end
end

function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end

    -- Set teams
    local teams = Spring.GetTeamList()
    local nullAI = {}
    for i = 1, #teams do
        local luaAI = Spring.GetTeamLuaAI(teams[i])
        if luaAI and string.find(string.lower(luaAI), "ai") then
            table.insert(nullAI, teams[i])
        end
    end

    if (#nullAI == 2) then
        leftTeam = CreateTeam(nullAI[1])
        rightTeam = CreateTeam(nullAI[2])
    else
        gadgetHandler:RemoveGadget()
        return
    end

    InitializeLeftSide()
    InitializeRightSide()
end

function gadget:GameFrame(f)
    if f == 1 then
        CreateLeftSide()
        CreateRightSide()
        dataSet = true
    end

    if f % spawnTime == 0 then
        DeployPlatform(leftSide.plats[leftSide.iterator + 1], leftTeam.nullAI, f, "e")
        leftSide.iterator = ((leftSide.iterator + 1) % #leftSide.plats)

        DeployPlatform(rightSide.plats[rightSide.iterator + 1], rightTeam.nullAI, f, "w")
        rightSide.iterator = ((rightSide.iterator + 1) % #rightSide.plats)
    end

    -- remove old waves
    if f > 0 and f % updateTime == 0 then
        local units
        if #waves > 0 and waves[1].spawnFrame + 4500 < f  then
            units = waves[1].units
            for j = 1, #units do
                if not Spring.GetUnitIsDead(units[j]) then
                    Spring.DestroyUnit(units[j])
                end
            end
            table.remove(waves, 1)
        end

        if #artyWave > 0 and artyWave[1].spawnFrame + 2500 < f then
            units = artyWave[1].units
            for j = 1, #units do
                if not Spring.GetUnitIsDead(units[j]) then
                    Spring.DestroyUnit(units[j])
                end
            end
            table.remove(artyWave, 1)
        end
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerID, attackerDefID, attackerTeam)
    if dataSet then
        if unitID == leftSide.baseId then
            Spring.GameOver({rightSide.team.allyTeam})
        elseif unitID == rightSide.baseId then
            Spring.GameOver({leftSide.team.allyTeam})
        elseif unitID == leftSide.turretId then
            for i = 1, #rightSide.team.playerList do
                Spring.AddTeamResource(rightSide.team.playerList[i], "metal", 800)
            end
        elseif unitID == rightSide.turretId then
            for i = 1, #leftSide.team.playerList do
                Spring.AddTeamResource(leftSide.team.playerList[i], "metal", 800)
            end
        end
    end
end

function gadget:AllowFeatureCreation(featureDefID, teamID, x, y, z)
    return false
end

function gadget:UnitIdle(unitID, unitDefID, unitTeam)
    -- local cQueue = Spring.GetCommandQueue(unitID, 1)
    -- if cQueue and #cQueue == 0 then
    --     if unitTeam == leftTeam.nullAI then
    --         Spring.GiveOrderToUnit(unitID, CMD.FIGHT, {5888, 0, 1530}, 0)
    --         Spring.Echo("Inactive unit")
    --     elseif unitTeam == rightTeam.nullAI then
    --         Spring.GiveOrderToUnit(unitID, CMD.FIGHT, {2303, 0, 1530}, 0)
    --     end
    -- end
end