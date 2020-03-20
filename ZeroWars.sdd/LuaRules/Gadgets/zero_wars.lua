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
local leftLayout, rightLayout = VFS.Include("LuaRules/Gadgets/ZeroWars/layout.lua")
local CustomCommanders = VFS.Include("LuaRules/Gadgets/ZeroWars/Custom_Commanders.lua");

local dataSet = false

local spawnTime = 800
local sides = {}
local leftSide
local rightSide
local customCommanders

local function IteratePlatform(side, frame, faceDir)
    side:CloneNextPlatform()
    local platform = side.platforms[(side.iterator % #side.platforms) + 1]

    -- deploy player commanders
    for i = 1, #platform.teamList do
        local team = platform.teamList[i]
        if customCommanders:HasCommander(team) and not customCommanders:HasClone(team) then
            local x, y = side.deployRect:GetCenterPos()
            customCommanders:SpawnClone(team, x, y, faceDir, side.attackXPos)
        end
    end
end

local function OnStart()
    leftSide:Deploy()
    rightSide:Deploy()
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

function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end

    -- set sides
    local allyTeamList = Spring.GetAllyTeamList()
    leftSide = Side:new(allyTeamList[1], leftLayout, "left")
    rightSide = Side:new(allyTeamList[2], rightLayout, "right")
    sides["left"] = leftSide
    sides["right"] = rightSide

    customCommanders = CustomCommanders:new()
end

function gadget:GameFrame(f)
    if f == 1 then OnStart() end

    leftSide:Update(f)
    rightSide:Update(f)

    if f > 0 and f %spawnTime == 0 then
        IteratePlatform(leftSide, f, "e")
        IteratePlatform(rightSide, f, "w")
    end
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
    if customCommanders:IsCommander(unitDefID) and not customCommanders:HasCommander(unitTeam) then
        customCommanders:SetOriginal(unitID, unitTeam)
    else
        local x = Spring.GetUnitPosition(unitID)
        if x then
            if x < 900 then
                Spring.SetUnitNeutral(unitID,true)
                if x >= 384 then Spring.MoveCtrl.Enable(unitID, false) end

            elseif x > 8192 - 900 then
                Spring.SetUnitNeutral(unitID,true)
                if x <= 7817 then Spring.MoveCtrl.Enable(unitID, false) end
                
            end
        end
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
        -- calculate commander victom cost, if victim is commander
        if customCommanders:IsCommander(unitDefID) then
            local attackerLevel = Spring.GetUnitRulesParam(attackerID, "level")
            local victimLevel = Spring.GetUnitRulesParam(unitID, "level")
            local reward = customCommanders:CalculateReward(attackerLevel, victimLevel)
            local xp = Spring.GetUnitExperience(attackerID) + reward
            Spring.SetUnitExperience(attackerID, xp)
        end

        customCommanders:TransferExperience(attackerID, attackerTeam)
    end

    -- transfer clone experience
    local isClone = Spring.GetUnitRulesParam(unitID, "clone")
    local original = Spring.GetUnitRulesParam(unitID, "original")
    if isClone and original and not Spring.GetUnitIsDead(original) then
        Spring.SetUnitExperience(original, Spring.GetUnitExperience(unitID))
    end
end

function gadget:AllowFeatureCreation(featureDefID, teamID, x, y, z)
    return false
end

function gadget:UnitIdle(unitID, unitDefID, unitTeam)
    local side = Spring.GetUnitRulesParam(unitID, "side")
    if side then
        sides[side]:AddIdleClone(unitID)
    end
end

-- Don't allow factories in center
function gadget:AllowUnitCreation(unitDefID, builderID, builderTeam, x, y, z, facing)
    local ud = UnitDefs[unitDefID]
    if ud.customParams.ismex then return true end

    if dataSet then
        if x and x >= 384 and x <= 7817 and (ud.isBuilding or ud.isBuilder) then
            return false
        end
    end
    return true
end

function gadget:AllowCommand(unitID, unitDefID, unitTeam, cmdID, cmdParams, cmdOptions, cmdTag, playerID, fromSynced, fromLua)
    if customCommanders:ProcessCommand(unitID, cmdID, cmdParams) then return true end
    if cmdID ~= 50 and cmdID ~= 1 and cmdID ~= 2 and Spring.GetUnitRulesParam(unitID, "clone") then return false end
    return true
end

function gadget:TeamDied(teamID)
    if leftSide:HasTeam(teamID) then
        leftSide:RemoveTeam(teamID)
    elseif rightSide:HasTeam(teamID) then
        rightSide:RemoveTeam(teamID)
    end
end