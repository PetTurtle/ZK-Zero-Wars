local Rect = VFS.Include("luarules/gadgets/util/rect.lua")

local width = 368
local height = 752

local leftX = 384
local rightX = Game.mapSizeX - width - leftX - 16

local y1 = 128
local y2 = 1152
local y3 = 2176

local platforms = {
    [1] = {
        [1] = Rect.new(leftX, y1, width, height),
        [2] = Rect.new(leftX, y2, width, height),
        [3] = Rect.new(leftX, y3, width, height)
    },
    [2] = {
        [1] = Rect.new(rightX, y1, width, height),
        [2] = Rect.new(rightX, y2, width, height),
        [3] = Rect.new(rightX, y3, width, height)
    }
}

local centerBuildings = {
    [1] = {
        {unitName = "nexus", x = 2496, z = 1530, dir = "e"},
        {unitName = "nexusturret", x = 3264, z = 1530, dir = "e"},
        {unitName = "staticrearm", x = 1550, z = 1226, dir = "e", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 1550, z = 1386, dir = "e", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 1550, z = 1529, dir = "e", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 1550, z = 1703, dir = "e", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 1550, z = 1848, dir = "e", noSelectable = true, neutral = true}
    },
    [2] = {
        {unitName = "nexus", x = 5696, z = 1530, dir = "w"},
        {unitName = "nexusturret", x = 4930, z = 1530, dir = "w"},
        {unitName = "staticrearm", x = 6641, z = 1226, dir = "w", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 6641, z = 1386, dir = "w", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 6641, z = 1529, dir = "w", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 6641, z = 1703, dir = "w", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 6641, z = 1848, dir = "w", noSelectable = true, neutral = true}
    }
}

return centerBuildings, platforms
