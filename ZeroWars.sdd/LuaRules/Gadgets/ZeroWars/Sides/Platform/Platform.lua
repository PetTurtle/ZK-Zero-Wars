local Rect = VFS.Include("LuaRules/Gadgets/ZeroWars/Rect.lua")

local spCreateUnit = Spring.CreateUnit
local spDestroyUnit = Spring.DestroyUnit
local spGetTeamUnits = Spring.GetTeamUnits
local spSetUnitPosition = Spring.SetUnitPosition

Platform = {}
Platform.__index = Platform

function Platform:new(rect, offsetX, offsetY)
    local o = {}
    setmetatable(o, Platform)
    o.rect = rect
    o.teamList = {}
    o.offsetX = offsetX
    o.offsetY = offsetY

    rect:SetOutlineBuildMask(0)

    return o
end

function Platform:AddTeam(teamID)
    table.insert(self.teamList, teamID)
end

function Platform:RemoveTeam(teamID)
    table.remove(self.teamList, teamID)
end

function Platform:HasTeam(teamID)
    for i = 1, #self.teamList do
        if self.teamList[i] == teamID then return i end
    end return false
end

function Platform:IsActive()
    if #self.teamList == 0 then return false end
    return true
end

function Platform:Deploy(playerUnits, customParams)
    local comPos = customParams["COMMANDER_SPAWN"]

    for i = 1, #self.teamList do
        for j = 1, #playerUnits do
            local unitID = self.rect:CreateUnit(playerUnits[j].unitName, playerUnits[j].x, playerUnits[j].z, playerUnits[j].dir, self.teamList[i])
            Spring.SetUnitResourcing(unitID, "umm", playerUnits[j].metalIncome or 0)
            Spring.SetUnitResourcing(unitID, "ume", playerUnits[j].energyIncome or 0)
        end
    end
end

function Platform:GetUnits(TeamID)
    return self.rect:GetUnits(TeamID)
end

function Platform:GetTeamUnits()
    local units = {}
    for i = 1, #self.teamList do
        units[i] = self.rect:GetUnits(self.teamList[i])
    end
    return units
end

return Platform