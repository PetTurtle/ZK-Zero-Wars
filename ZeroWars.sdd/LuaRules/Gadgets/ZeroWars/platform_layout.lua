local Rect = VFS.Include("LuaRules/Gadgets/ZeroWData/Rect.lua")
local Platform = VFS.Include("LuaRules/Gadgets/ZeroWData/Platform.lua")

local Platform_Layout = {}

-- side : side of map "left", "right"
function Platform_Layout.new(side)

    local platforms = {}

    if side == "left" then
        table.insert(platforms, Platform.new(128, 1280,  1016))
        table.insert(platforms, Platform.new(1152, 1280,  0))
        table.insert(platforms, Platform.new(2184, 1280, -1016))
    elseif side == "right" then
        table.insert(platforms, Platform.new(128, -1280,  1016))
        table.insert(platforms, Platform.new(1152, -1280,  0))
        table.insert(platforms, Platform.new(2184, -1280, -1016))
    end

    return platforms
end

return Platform_Layout