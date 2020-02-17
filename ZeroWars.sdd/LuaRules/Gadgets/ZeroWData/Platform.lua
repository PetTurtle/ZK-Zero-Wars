local Rect = VFS.Include("LuaRules/Gadgets/ZeroWData/Rect.lua")

local Platform = {}

local mapWidth = 8192
local platSize = 760

function Platform.new(platYOffset, offsetX, offsetY)

	local rect
	local deployRect
	if offsetX > 0 then
		rect = Rect.new(0, platYOffset, platSize, platSize)
		deployRect = Rect.new(rect.x1 + platSize/2, rect.y1, platSize/2, platSize)
	else
		rect = Rect.new(mapWidth - platSize, platYOffset, platSize, platSize)
		deployRect = Rect.new(rect.x1, rect.y1, platSize/2, platSize)
	end

	local platform = {
        rect = rect,
        deployRect = deployRect,
        offsetX = offsetX,
        offsetY = offsetY,
        players = {},
	}

	function platform:HasPlayer(playerID)
		for i = 0, #self.players do
            if self.players[i] == playerID then
                return i
            end
        end
        return false
	end

	return platform
end

return Platform