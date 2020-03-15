include("LuaRules/Configs/customcmds.h.lua")

local custom_com_defs = include("LuaRules/Configs/custom_com_defs.lua")

CustomCommanders = {}
CustomCommanders.__index = CustomCommanders

function CustomCommanders:new ()
    local o = {}
    setmetatable(o, CustomCommanders)
    o.__index = self
    o.commanders = {}

    if GG.custom_com_defs then
        o.custom_com_defs = GG.custom_com_defs
    else
        o.custom_com_defs = custom_com_defs
        GG.custom_com_defs = custom_com_defs
    end
    
    return o
end

local function callScript(unitID, funcName, args)
	local func = Spring.UnitScript.GetScriptEnv(unitID)[funcName]
	if func then
		Spring.UnitScript.CallAsUnit(unitID, func, args)
	end
end

function CustomCommanders:TransferExperience(unitID, unitTeam)
    local xp = Spring.GetUnitExperience(unitID)
    local original = self.commanders[unitTeam].original
    local clone = self.commanders[unitTeam].clone

    if clone == unitID then
        local level = Spring.GetUnitRulesParam(original, "level");
        

        while (xp >= level and level <= 16) do
            xp = math.max(0, xp - level)
            level = level + 1
            Spring.SetUnitRulesParam(original, "level", level)
            local points = Spring.GetUnitRulesParam(original, "points");
            Spring.SetUnitRulesParam(original, "points", points + 1)
            callScript(original, "LevelUp")

            if self:HasClone(unitTeam) then
                Spring.SetUnitExperience(clone, xp)
                Spring.SetUnitRulesParam(clone, "level", level)
                callScript(clone, "LevelUp")
            end
            
        end
        Spring.SetUnitExperience(original, xp)
        Spring.GiveOrderToUnit(original, CMD.FIRE_STATE, {2}, 0)
    end
end

function CustomCommanders:IsCommander(unitDefID)
    if (UnitDefs[unitDefID].customParams.customcom) then return true end
    return false
end

function CustomCommanders:HasCommander(team)
    if team and self.commanders[team] then return true end
    return false
end

function CustomCommanders:HasClone(team)
    if self:HasCommander(team) and self.commanders[team].clone and Spring.GetUnitIsDead(self.commanders[team].clone) == false then return true end
    return false
end

function CustomCommanders:SetOriginal(unitID, unitTeam)
    self.commanders[unitTeam] = {original = unitID, clone = nil}
    Spring.SetUnitRulesParam(unitID, "level", 1)
    Spring.SetUnitRulesParam(unitID, "points", 0)
    Spring.SetUnitRulesParam(unitID, "path1", 0)
    Spring.SetUnitRulesParam(unitID, "path2", 0)
    Spring.SetUnitRulesParam(unitID, "path3", 0)
    Spring.SetUnitRulesParam(unitID, "path4", 0)
    Spring.SetUnitRulesParam(unitID, "original", 1)
    callScript(unitID, "LevelUp")
    Spring.SetUnitResourcing(unitID, "umm", 6)
    Spring.SetUnitResourcing(unitID, "ume", 6)
end

function CustomCommanders:SpawnClone(unitTeam, x, y, faceDir, attackXPos)
    local original = self.commanders[unitTeam].original
    local unitDefID = Spring.GetUnitDefID(original)
    local clone = Spring.CreateUnit(unitDefID, x, 150, y, faceDir, unitTeam)
    Spring.GiveOrderToUnit(clone, CMD.FIGHT, {attackXPos, 0, y}, 0)
    self.commanders[unitTeam].clone = clone

    Spring.SetUnitRulesParam(clone, "level", Spring.GetUnitRulesParam(original, "level"))
    Spring.SetUnitRulesParam(clone, "points", Spring.GetUnitRulesParam(original, "points"))
    Spring.SetUnitRulesParam(clone, "path1", Spring.GetUnitRulesParam(original, "path1"))
    Spring.SetUnitRulesParam(clone, "path2", Spring.GetUnitRulesParam(original, "path2"))
    Spring.SetUnitRulesParam(clone, "path3", Spring.GetUnitRulesParam(original, "path3"))
    Spring.SetUnitRulesParam(clone, "path4", Spring.GetUnitRulesParam(original, "path4"))
    Spring.SetUnitRulesParam(clone, "original", 0)
    Spring.SetUnitRulesParam(clone, "originalID", original)

    callScript(clone, "LevelUp")
    callScript(clone, "Upgrade")

    Spring.SetUnitExperience(clone, Spring.GetUnitExperience(original))
end

 -- process upgrade command
function CustomCommanders:ProcessCommand(unitID, cmdID, cmdParams)
    if cmdID ~= custom_com_defs.CMD_CUSTOM_UPGRADE then return false end
   
    local points = Spring.GetUnitRulesParam(unitID, "points");
    Spring.SetUnitRulesParam(unitID, "points", points - 1)

    local path = "path"..cmdParams[1]
    Spring.SetUnitRulesParam(unitID, path, Spring.GetUnitRulesParam(unitID, path) + 1)
    callScript(unitID, "Upgrade")

    -- give upgrade to clone
    local team = Spring.GetUnitTeam(unitID)
    if self:HasClone(team) then
        local clone = self.commanders[team].clone
        Spring.SetUnitRulesParam(clone, path, Spring.GetUnitRulesParam(unitID, path))
        callScript(clone, "LevelUp")
        callScript(clone, "Upgrade")
        Spring.GiveOrderToUnit(clone, CMD.FIRE_STATE, {2}, 0)
    end

    Spring.GiveOrderToUnit(unitID, CMD.FIRE_STATE, {2}, 0)
    return true
end

return CustomCommanders