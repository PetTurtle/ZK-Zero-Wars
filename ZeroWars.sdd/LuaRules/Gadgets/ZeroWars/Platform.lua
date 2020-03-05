local Rect = VFS.Include("LuaRules/Gadgets/ZeroWars/Rect.lua")

local spCreateUnit = Spring.CreateUnit
local spGetTeamUnits = Spring.GetTeamUnits
local spSetUnitPosition = Spring.SetUnitPosition

Platform = {}
Platform.__index = Platform

function Platform:new(rect, offsetX, offsetY)
    local o = {}
    setmetatable(o, Platform)
    o.rect = rect
    o.playerList = {}
    o.offsetX = offsetX
    o.offsetY = offsetY
    return o
end

function Platform:AddPlayer(playerID)
    table.insert(self.playerList, playerID)
end

function Platform:HasPlayer(playerID)
    for i = 1, #self.playerList do
        if self.playerList[i] == playerID then return i end
    end return false
end

function Platform:Deploy(platUnits)
    local playerUnits = platUnits.playerUnits
    local comPos = platUnits.customParams["COMMANDER_SPAWN"]

    for i = 1, #self.playerList do
        for j = 1, #playerUnits do
            self.rect:CreateUnit(playerUnits[j].unitName, playerUnits[j].x, playerUnits[j].z, playerUnits[j].dir, self.playerList[i])
        end

        -- move commander
        local playerUnits = spGetTeamUnits(self.playerList[i])
        spSetUnitPosition(playerUnits[1], comPos.x, comPos.z)
    end
end

function Platform:GetUnits(playerID)
    return self.rect:GetUnits(playerID)
end

return Platform