local Rect = VFS.Include("LuaRules/Gadgets/ZeroWars/Rect.lua")
local Platform = VFS.Include("LuaRules/Gadgets/ZeroWars/Platform.lua")

local Platform_Layout = {}

local mapWidth = Game.mapSizeX
local mapHeight = Game.mapSizeZ


-- side : side of map "left", "right"
function Platform_Layout.new(side)

    local platforms = {}
    local deployPlatform

    local platWidth = 380
    local platHeight = 760
    local platLeftOffset = 380
    local platRightOffset = mapWidth - platWidth - 380

    if side == "left" then
        table.insert(platforms, Platform.new(Rect.new(platLeftOffset, 128, platWidth, platHeight), 1280,  1016))
        table.insert(platforms, Platform.new(Rect.new(platLeftOffset, 1152, platWidth, platHeight), 1280,  0))
        table.insert(platforms, Platform.new(Rect.new(platLeftOffset, 2184, platWidth, platHeight), 1280, -1016))

        deployPlatform = Rect.new(1664, 1152, platWidth, platHeight)
    elseif side == "right" then
        table.insert(platforms, Platform.new(Rect.new(platRightOffset, 128, platWidth, platHeight), -1280,  1016))
        table.insert(platforms, Platform.new(Rect.new(platRightOffset, 1152, platWidth, platHeight), -1280,  0))
        table.insert(platforms, Platform.new(Rect.new(platRightOffset, 2184, platWidth, platHeight), -1280, -1016))

        deployPlatform = Rect.new(6144, 1152, platWidth, platHeight)
    end
    local platform_layout = {
        platforms = platforms,
        deployPlatform = deployPlatform,
    }
    return platform_layout
end

return Platform_Layout