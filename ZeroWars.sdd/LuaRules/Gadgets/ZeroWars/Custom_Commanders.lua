include("LuaRules/Configs/customcmds.h.lua")

local custom_com_defs = include("LuaRules/Configs/custom_com_defs.lua")

CustomCommanders = {
    commanders,
    custom_com_defs,
}

function CustomCommanders:new ()
    o = {}
    setmetatable(o, self)
    self.__index = self
    self.commanders = {}
    self.custom_com_defs = custom_com_defs
    GG.custom_com_defs = custom_com_defs
    return o
end

local function callScript(unitID, funcName, args)
	local func = Spring.UnitScript.GetScriptEnv(unitID)[funcName]
	if func then
		Spring.UnitScript.CallAsUnit(unitID, func, args)
	end
end

function CustomCommanders:TransferExperience(unitID, unitTeam, xp)
    local original = self.commanders[unitTeam].original
    if original ~= unitID then
        local level = Spring.GetUnitRulesParam(original, "level");
        local newXP = Spring.GetUnitExperience(original) + xp
        if (newXP >= level) then
            newXP = newXP - level
            Spring.SetUnitRulesParam(original, "level", level + 1)

            local points = Spring.GetUnitRulesParam(original, "points");
            Spring.SetUnitRulesParam(original, "points", points + 1)
            callScript(original, "LevelUp", level + 1)
        end
        Spring.SetUnitExperience(original, newXP)
    end
end

function CustomCommanders:IsCommander(unitDefID)
    if (UnitDefs[unitDefID].customParams.customcom) then return true end
    return false
end

function CustomCommanders:HasCommander(team)
    if self.commanders[team] then return true end
    return false
end

function CustomCommanders:HasClone(team)
    if self.commanders[team].clone and Spring.GetUnitIsDead(self.commanders[team].clone) == false then return true end
    return false
end

function CustomCommanders:SetOriginal(unitID, unitTeam)
    self.commanders[unitTeam] = {original = unitID, clone = nil}
    Spring.SetUnitRulesParam(unitID, "level", 1)
    Spring.SetUnitRulesParam(unitID, "points", 1)
    Spring.SetUnitRulesParam(unitID, "path1", 0)
    Spring.SetUnitRulesParam(unitID, "path2", 0)
    Spring.SetUnitRulesParam(unitID, "path3", 0)
    Spring.SetUnitRulesParam(unitID, "path4", 0)
    Spring.SetUnitRulesParam(unitID, "original", 1)
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

    callScript(clone, "LevelUp", Spring.GetUnitRulesParam(original, "level"))
end

function CustomCommanders:ProcessCommand(unitID, cmdID, cmdParams)
    if cmdID ~= custom_com_defs.CMD_CUSTOM_UPGRADE then return false end

    local points = Spring.GetUnitRulesParam(unitID, "points");
    Spring.SetUnitRulesParam(unitID, "points", points - 1)
    Spring.GiveOrderToUnit(unitID, CMD.FIRE_STATE, {2}, 0)
    
    return true
end

return CustomCommanders