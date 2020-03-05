local spCreateUnit = Spring.CreateUnit
local spGetUnitsInRectangle = Spring.GetUnitsInRectangle

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

return Rect