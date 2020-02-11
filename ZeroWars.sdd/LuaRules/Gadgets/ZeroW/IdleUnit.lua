local IdleUnit = {}

function IdleUnit.new(unit, side)

	local idleUnit = {
        unit = unit,
        side = side
    }
	return idleUnit
end

return IdleUnit