local Rect = VFS.Include("LuaRules/Gadgets/ZeroWars/Rect.lua")
local Platform = VFS.Include("LuaRules/Gadgets/ZeroWars/Platform.lua")

local Platform_Layout = {}

local mapWidth = Game.mapSizeX
local mapHeight = Game.mapSizeZ

local platEdgeOffset = 380
local platWidth = 380
local platHeight = 760

-- side : side of map "left", "right"
function Platform_Layout.new(side)

    
    local platforms = {}
    local deployPlatform

    if side == "left" then
        table.insert(platforms, Platform.new(Rect.new(platEdgeOffset, 128, platWidth, platHeight), 1280,  1016))
        table.insert(platforms, Platform.new(Rect.new(platEdgeOffset, 1152, platWidth, platHeight), 1280,  0))
        table.insert(platforms, Platform.new(Rect.new(platEdgeOffset, 2184, platWidth, platHeight), 1280, -1016))

        deployPlatform = Rect.new(platforms[1].rect.width + 1280, 1152, platWidth, platHeight)
    elseif side == "right" then
        table.insert(platforms, Platform.new(Rect.new(mapWidth - platEdgeOffset - platWidth, 128, platWidth, platHeight), -1280,  1016))
        table.insert(platforms, Platform.new(Rect.new(mapWidth - platEdgeOffset - platWidth, 1152, platWidth, platHeight), -1280,  0))
        table.insert(platforms, Platform.new(Rect.new(mapWidth - platEdgeOffset - platWidth, 2184, platWidth, platHeight), -1280, -1016))

        deployPlatform = Rect.new(platforms[1].rect.x1 - 1280, 1152, platWidth, platHeight)
    end
    local platform_layout = {
        platforms = platforms,
        deployPlatform = deployPlatform,
    }
    return platform_layout
end

return Platform_Layout