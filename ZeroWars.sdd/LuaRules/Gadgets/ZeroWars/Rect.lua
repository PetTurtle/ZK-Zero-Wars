local spCreateUnit = Spring.CreateUnit

local Rect = {}

function Rect.new(x1, y1, x2, y2)

    local width = x2 - x1
    local height = y2 - y1

	local rect = { x1 = x1, y1 = y1, x2 = x2, y2 = y2, width = width, height = height, }

    function rect:HasPoint(x, y)
        return x > self.x1 and x < self.x2 and y > self.y1 and y < self.y2
    end

    function rect:CreateUnit(unit, x, z, dir, team)
        return spCreateUnit(unit, self.x1 + x, 150, self.y1 + z, dir , team)
    end
    
	return rect
end

return Rect