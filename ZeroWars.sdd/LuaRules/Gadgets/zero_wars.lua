if not gadgetHandler:IsSyncedCode() then return false end

function gadget:GetInfo()
    return {
        name = "Zero Wars",
        desc = "zero wars",
        author = "petturtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 1,
        enabled = true,
        handler = true
    }
end

include("LuaRules/Configs/customcmds.h.lua")
local Side = VFS.Include("LuaRules/Gadgets/ZeroWars/Sides/Side.lua")
local PlatformDeployer = VFS.Include("LuaRules/Gadgets/ZeroWars/Platform_Deployer.lua")
local CustomCommanders = VFS.Include("LuaRules/Gadgets/ZeroWars/Custom_Commanders.lua");

local dataSet = false

local spawnTime = 800
local maxSpawnsPerFrame = 12

local leftSide
local rightSide

local platformDeployer
local customCommanders

local updateTime = 60
local idleUnits = {}
local validCommands = {
    CMD.FIRE_STATE,
    CMD.MOVE_STATE,
    CMD.REPEAT,
    CMD.CLOAK,
    CMD.ONOFF,
    CMD.TRAJECTORY,
    CMD_UNIT_AI,
    CMD_AIR_STRAFE,
    CMD_PUSH_PULL,
    CMD_AP_FLY_STATE,
    CMD_UNIT_BOMBER_DIVE_STATE,
    CMD_AP_FLY_STATE,
}

local function IteratePlatform(side, frame, faceDir)
    local platform = side.platforms[(side.iterator % #side.platforms) + 1]

    -- deploy units on platform
    platformDeployer:Deploy(platform, side.deployRect, faceDir, side.nullAI, side.attackXPos);

    -- deploy player commanders
    for i = 1, #platform.teamList do
        local team = platform.teamList[i]
        if customCommanders:HasCommander(team) and not customCommanders:HasClone(team) then
            local x, y = side.deployRect:GetCenterPos()
            customCommanders:SpawnClone(team, x, y, faceDir, side.attackXPos)
        end
    end
    -- iterate platform
    side.iterator=((side.iterator + 1) % #side.platforms)
end

local function OnStart()
    leftSide:Deploy("left")
    rightSide:Deploy("right")
    dataSet = true

    -- Clear resources and default commander
    local allyTeamList = Spring.GetAllyTeamList()
    for i = 1, #allyTeamList do
        local teamList = Spring.GetTeamList(allyTeamList[i])
        for j = 1, #teamList do
            Spring.SetTeamResource(teamList[j], "metal", 0)
            local units = Spring.GetTeamUnits(teamList[j])
            if units and #units > 0 then Spring.DestroyUnit(units[1], false, true) end
        end
    end
end

local function OnUpdateFrame(frame)
    platformDeployer:ClearTimedOut(frame)
    -- add attack order to idle units
    for i = #idleUnits, 1, -1 do
        if not Spring.GetUnitIsDead(idleUnits[i].unit) then
            local cQueue = Spring.GetCommandQueue(idleUnits[i].unit, 1)
            if cQueue and #cQueue == 0 then
                Spring.GiveOrderToUnit(idleUnits[i].unit, CMD.INSERT, {-1, CMD.FIGHT, CMD.OPT_SHIFT, idleUnits[i].side.attackXPos, 0, 1530}, {"alt"});
            end
        end
        table.remove(idleUnits, i)
    end
end

function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end

    -- set sides
    local allyTeamList = Spring.GetAllyTeamList()
    leftSide = Side:new(allyTeamList[1], "left", 5888)
    rightSide = Side:new(allyTeamList[2], "right", 2303)
    platformDeployer = PlatformDeployer:new()
    customCommanders = CustomCommanders:new()
    GG.leftSide = leftSide
    GG.rightSide = rightSide
end

function gadget:GameFrame(f)
    if f == 1 then OnStart() end
    if f > 0 and f % updateTime == 0 then OnUpdateFrame(f) end

    platformDeployer:IterateQueue(maxSpawnsPerFrame, f)

    if f > 0 and f %spawnTime == 0 then
        IteratePlatform(leftSide, f, "e")
        IteratePlatform(rightSide, f, "w")
    end
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
    if customCommanders:IsCommander(unitDefID) and not customCommanders:HasCommander(unitTeam) then
        customCommanders:SetOriginal(unitID, unitTeam)
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerID, attackerDefID, attackerTeam)
    if dataSet then
        if unitID == leftSide.baseId then
            Spring.GameOver({rightSide.allyID})
        elseif unitID == rightSide.baseId then
            Spring.GameOver({leftSide.allyID})
        elseif unitID == leftSide.turretId then
            for i = 1, #rightSide.teamList do
                Spring.AddTeamResource(rightSide.teamList[i], "metal", 800)
            end
        elseif unitID == rightSide.turretId then
            for i = 1, #leftSide.teamList do
                Spring.AddTeamResource(leftSide.teamList[i], "metal", 800)
            end
        end
    end
    if attackerDefID and customCommanders:IsCommander(attackerDefID) and customCommanders:HasCommander(attackerTeam) then
        customCommanders:TransferExperience(attackerID, attackerTeam)
    end
end

function gadget:AllowFeatureCreation(featureDefID, teamID, x, y, z)
    return false
end

function gadget:UnitIdle(unitID, unitDefID, unitTeam)
    if unitTeam == leftSide.nullAI then
        idleUnits[#idleUnits + 1] = {unit = unitID, side = leftSide}
    elseif unitTeam == rightSide.nullAI then
        idleUnits[#idleUnits + 1] = {unit = unitID, side = rightSide}
    end
end

-- Don't allow factories in center
function gadget:AllowUnitCreation(unitDefID, builderID, builderTeam, x, y, z, facing)
    local ud = UnitDefs[unitDefID]
    if dataSet then
        if x and x > 374 and x < 7817 then
            if ud.isFactory or ud.isStaticBuilder then
                return false
            end
            if ud.isBuilding and ud.maxWeaponRange and ud.maxWeaponRange >= 1200 then
                return false
            end
        end
        
        xsize = ud.xsize and tonumber(ud.xsize) / 4 or 1
        zsize = ud.zsize and tonumber(ud.zsize) / 4 or 1
        local gridSize = 16
        if Spring.GetGroundBlocked(x - xsize * gridSize, z - zsize * gridSize, x + (xsize-1) * gridSize, z + (zsize-1) * gridSize) ~= false then
            return false
        end
    elseif ud.isTransport then
        return false
    end
    return true
end

function gadget:AllowCommand(unitID, unitDefID, unitTeam, cmdID, cmdParams, cmdOptions, cmdTag, playerID, fromSynced, fromLua)
    local x, y, z = Spring.GetUnitPosition(unitID)
    local ud = UnitDefs[unitDefID]

    if customCommanders:ProcessCommand(unitID, cmdID, cmdParams) then return true end

    if not x or x < 900 or x > 8192 - 900 then
        if ud.isBuilder then
            return true
        end
        for i = 1, #validCommands do
            if (validCommands[i] == cmdID) then
                return true
            end
        end
        return false
    end
    return true
end

function gadget:TeamDied(teamID)
    if leftSide:HasTeam(teamID) then
        leftSide:RemoveTeam(teamID)
    elseif rightSide:HasTeam(teamID) then
        rightSide:RemoveTeam(teamID)
    end
end