include("LuaRules/Configs/customcmds.h.lua")

CustomCommanders = {
    commanders,
}

function CustomCommanders:new ()
    o = {}
    setmetatable(o, self)
    self.__index = self
    self.commanders = {}
    return o
end

function CustomCommanders:TransferExperience(unitID, unitTeam, xp)
    local original = self.commanders[unitTeam].original
    if original ~= unitID then
        Spring.SetUnitExperience(original, Spring.GetUnitExperience(original) + xp)
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
    Spring.SetUnitRulesParam(unitID, "points", 0)
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
end

return CustomCommanders