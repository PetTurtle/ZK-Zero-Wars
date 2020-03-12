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

function Platform:Deploy(platUnits)
    local playerUnits = platUnits.playerUnits
    local comPos = platUnits.customParams["COMMANDER_SPAWN"]

    for i = 1, #self.teamList do
        for j = 1, #playerUnits do
            self.rect:CreateUnit(playerUnits[j].unitName, playerUnits[j].x, playerUnits[j].z, playerUnits[j].dir, self.teamList[i])
        end

        -- move commander
        local playerUnits = spGetTeamUnits(self.teamList[i])
        spDestroyUnit(playerUnits[1], false, true)
    end
end

function Platform:GetUnits(teamList)
    return self.rect:GetUnits(teamList)
end

return Platform