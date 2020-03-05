local spCreateUnit = Spring.CreateUnit
local spGetUnitsInRectangle = Spring.GetUnitsInRectangle
local spSetSquareBuildingMask = Spring.SetSquareBuildingMask

Rect = {}
Rect.__index = Rect

function Rect:new(x, y, width, height)
    local o = {}
    setmetatable(o, Rect)
    o.x1 = x
    o.y1 = y
    o.x2 = (x + width)
    o.y2 = (y + height)
    o.width = width
    o.height = height
    return o
end

function Rect:HasPoint(x, y)
    return x > self.x1 and x < self.x2 and y > self.y1 and y < self.y2
end

function Rect:CreateUnit(unit, x, z, dir, team)
    return spCreateUnit(unit, self.x1 + x, 150, self.y1 + z, dir , team)
end

function Rect:GetUnits(playerID)
    return spGetUnitsInRectangle(self.x1, self.y1, self.x2, self.y2, playerID)
end

function Rect:GetPosOffset(target)
    local newX = target.x1 - self.x1
    local newY = target.y1 - self.y1
    local pos = {x = newX, y = newY,}
    return pos
end

function Rect:GetCenterPos()
    local xDiff = (self.x2 - self.x1) / 2
    local yDiff = (self.y2 - self.y1) / 2
    local x = self.x1 + xDiff
    local y = self.y1 + yDiff
    return x, y
end

function Rect:SetBuildMask(mask)
    local startX = math.floor(self.x1 / 16)
    local startZ = math.floor(self.y1 / 16)
    local width = math.floor(self.width / 16)
    local height = math.floor(self.height / 16)

    for x = startX, startX + width do
        for z = startZ, startZ + height do
            spSetSquareBuildingMask(x, z, mask)
        end
    end
end

function Rect:SetOutlineBuildMask(mask)
    local startX = math.floor(self.x1 / 16)
    local startZ = math.floor(self.y1 / 16)
    local width = math.floor(self.width / 16)
    local height = math.floor(self.height / 16)

    -- top
    for x = startX, startX + width do
        spSetSquareBuildingMask(x, startZ - 1, mask)
    end

    -- bottom
    for x = startX, startX + width do
        spSetSquareBuildingMask(x, startZ + height + 1, mask)
    end

    -- left
    for z = startZ, startZ + height do
        spSetSquareBuildingMask(startX - 1, z, mask)
    end

    -- right
    for z = startZ, startZ + height do
        spSetSquareBuildingMask(startX + width + 1, z, mask)
    end
end

return Rect