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

function CustomCommanders:IsCommander(unitDefID)
    local ud = UnitDefs[unitDefID]
    if (ud.customParams.customcom) then
        return true
    end
    return false
end

function CustomCommanders:InitializeCustomCommander(unitID, unitTeam)

    local isClone = false
    local id = 0
    for i = 1, #self.commanders do
        if (self.commanders[i].team == unitTeam) then
            isClone = false
            id = i
            break
        end
    end
    if isClone then
        self.commanders[id].clone = unitID
    else
        table.insert(self.commanders, {team = unitTeam, original = unitID, clone = nil})
    end
end

function CustomCommanders:TransferExperience(unitID, unitTeam, xp)
    local isClone = false
    local id = 0
    for i = 1, #self.commanders do
        if (self.commanders[i].team == unitTeam) then
            isClone = false
            id = i
            break
        end
    end
    if isClone then
        local original = self.commanders[id].original
        Spring.SetUnitExperience(original, Spring.GetUnitExperience(original + xp))
    end
end


return CustomCommanders