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
end

function CustomCommanders:SpawnClone(unitTeam, x, y, faceDir, attackXPos)
    local unitDefID = Spring.GetUnitDefID(self.commanders[unitTeam].original)
    local clone = Spring.CreateUnit(unitDefID, x, 150, y, faceDir, unitTeam)
    Spring.GiveOrderToUnit(clone, CMD.FIGHT, {attackXPos, 0, y}, 0)
    self.commanders[unitTeam].clone = clone
end

return CustomCommanders