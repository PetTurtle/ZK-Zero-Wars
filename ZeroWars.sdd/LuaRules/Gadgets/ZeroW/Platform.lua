local Rect = VFS.Include("LuaRules/Gadgets/ZeroW/Rect.lua")

local Platform = {}

local mapWidth = 8192
local platSize = 760

function Platform.new(platYOffset, offsetX, offsetY)

	local rect
	local dOffset 
	local deployRect
	if offsetX > 0 then
		rect = Rect.new(0, platYOffset, platSize, platSize)
		dOffset = (rect.x2 - rect.x1) / 2
		deployRect = Rect.new(rect.x1 + dOffset, rect.y1, rect.x2, rect.y2)
	else
		rect = Rect.new(mapWidth - platSize, platYOffset, platSize, platSize)
		dOffset = (rect.x2 - rect.x1) / 2
		deployRect = Rect.new(rect.x1, rect.y1, rect.x2 - dOffset, rect.y2)
	end

	local platform = {
        rect = rect,
        deployRect = deployRect,
        offsetX = offsetX,
        offsetY = offsetY,
        players = {},
	}
	return platform
end

return Platform