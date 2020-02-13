local Rect = {}

function Rect.new(x, y, width, height)

	local rect = {
		x1 = x,
		y1 = y,
		x2 = x + width,
		y2 = y + height,
    }

    function rect:containsPoint(x, y)
        return x > x1 and x < x2 and y > y1 and y < y2
    end
    
	return rect
end

return Rect