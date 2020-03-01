local spCreateUnit = Spring.CreateUnit
local spGetUnitsInRectangle = Spring.GetUnitsInRectangle

local Rect = {}

function Rect.new(x, y, width, height)

    local rect = { 
        x1 = x,
        y1 = y,
        x2 = (x + width),
        y2 = (y + height),
        width = width,
        height = height, 
    }

    function rect:HasPoint(x, y)
        return x > self.x1 and x < self.x2 and y > self.y1 and y < self.y2
    end

    function rect:CreateUnit(unit, x, z, dir, team)
        return spCreateUnit(unit, self.x1 + x, 150, self.y1 + z, dir , team)
    end

    function rect:GetUnits(playerID)
        return spGetUnitsInRectangle(self.x1, self.y1, self.x2, self.y2, playerID)
    end

    function rect:GetPosOffset(target)
        local newX = target.x1 - self.x1
        local newY = target.y1 - self.y1
        local pos = {x = newX, y = newY,}
        return pos
    end

    function rect:GetCenterPos()
        local xDiff = (self.x2 - self.x1) / 2
        local yDiff = (self.y2 - self.y1) / 2
        local x = self.x1 + xDiff
        local y = self.y1 + yDiff
        return x, y
    end

	return rect
end

return Rect