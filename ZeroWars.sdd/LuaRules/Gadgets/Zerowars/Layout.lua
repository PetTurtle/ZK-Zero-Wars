local Rect = VFS.Include("LuaRules/Gadgets/Data/Rect.lua")
local Platform = VFS.Include("LuaRules/Gadgets/Zerowars/Platform.lua")

local mapWidth = Game.mapSizeX
local mapHeight = Game.mapSizeZ

local layout = {
    [1] = {},
    [2] = {}
}

----------------------------------
-- Side Data
----------------------------------

layout[1].attackXPos = 5888
layout[1].faceDir = "e"

layout[2].attackXPos = 2303
layout[2].faceDir = "w"

----------------------------------
-- Side Platforms
----------------------------------

local platWidth = 368
local platHeight = 752
local platLeftOffset = 384
local platRightOffset = mapWidth - platWidth - platLeftOffset - 16

layout[1].platforms = {
    Platform.new(Rect.new(platLeftOffset, 128, platWidth, platHeight)),
    Platform.new(Rect.new(platLeftOffset, 1152, platWidth, platHeight)),
    Platform.new(Rect.new(platLeftOffset, 2176, platWidth, platHeight))
}
layout[1].deployRect = Rect.new(1664, 1152, platWidth, platHeight)
layout[1].deployRect:setBuildMask(0)

layout[2].platforms = {
    Platform.new(Rect.new(platRightOffset, 128, platWidth, platHeight)),
    Platform.new(Rect.new(platRightOffset, 1152, platWidth, platHeight)),
    Platform.new(Rect.new(platRightOffset, 2176, platWidth, platHeight))
}
layout[2].deployRect = Rect.new(6144, 1152, platWidth, platHeight)
layout[2].deployRect:setBuildMask(0)

----------------------------------
-- Side Buildings
----------------------------------

layout[1].buildings = {
    {unitName = "baseturret", x = 2496, z = 1530, dir = "e"},
    {unitName = "centerturret", x = 3264, z = 1530, dir = "e"},
    {unitName = "staticrearm", x = 1550, z = 1226, dir = "e", noSelectable = true, neutral = true},
    {unitName = "staticrearm", x = 1550, z = 1386, dir = "e", noSelectable = true, neutral = true},
    {unitName = "staticrearm", x = 1550, z = 1529, dir = "e", noSelectable = true, neutral = true},
    {unitName = "staticrearm", x = 1550, z = 1703, dir = "e", noSelectable = true, neutral = true},
    {unitName = "staticrearm", x = 1550, z = 1848, dir = "e", noSelectable = true, neutral = true}
}

layout[2].buildings = {
    {unitName = "baseturret", x = 5696, z = 1530, dir = "w"},
    {unitName = "centerturret", x = 4930, z = 1530, dir = "w"},
    {unitName = "staticrearm", x = 6641, z = 1226, dir = "w", noSelectable = true, neutral = true},
    {unitName = "staticrearm", x = 6641, z = 1386, dir = "w", noSelectable = true, neutral = true},
    {unitName = "staticrearm", x = 6641, z = 1529, dir = "w", noSelectable = true, neutral = true},
    {unitName = "staticrearm", x = 6641, z = 1703, dir = "w", noSelectable = true, neutral = true},
    {unitName = "staticrearm", x = 6641, z = 1848, dir = "w", noSelectable = true, neutral = true}
}

----------------------------------
-- Player Platform Units
----------------------------------

layout[1].playerUnits = {
    {unitName = "basiccon", x = -140, z = 350, dir = "e", metalIncome = 6, isBlocking = false, energyIncome = 6},
}

layout[2].playerUnits = {
    {unitName = "basiccon", x = 520, z = 410, dir = "w", metalIncome = 6, isBlocking = false, energyIncome = 6},
}


return layout
