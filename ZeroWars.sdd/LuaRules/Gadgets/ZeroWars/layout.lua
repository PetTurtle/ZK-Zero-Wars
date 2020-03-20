local Rect = VFS.Include("LuaRules/Gadgets/ZeroWars/Rect.lua")
local Platform = VFS.Include("LuaRules/Gadgets/ZeroWars/Sides/Platform/Platform.lua")

local mapWidth = Game.mapSizeX
local mapHeight = Game.mapSizeZ

local leftSide = {}
local rightSide = {}

----------------------------------
-- Side Data
----------------------------------

leftSide.attackXPos = 5888
leftSide.faceDir = "e"

rightSide.attackXPos = 2303
rightSide.faceDir = "w"

----------------------------------
-- Side Platforms
----------------------------------

local platWidth = 368
local platHeight = 752
local platLeftOffset = 384
local platRightOffset = mapWidth - platWidth - platLeftOffset - 16

leftSide.platforms = {
    Platform:new(Rect:new(platLeftOffset, 128, platWidth, platHeight), 1280, 1016),
    Platform:new(Rect:new(platLeftOffset, 1152, platWidth, platHeight), 1280, 0),
    Platform:new(Rect:new(platLeftOffset, 2176, platWidth, platHeight), 1280, -1016)
}
leftSide.deployRect = Rect:new(1664, 1152, platWidth, platHeight)

rightSide.platforms = {
    Platform:new(Rect:new(platRightOffset, 128, platWidth, platHeight), -1280, 1016),
    Platform:new(Rect:new(platRightOffset, 1152, platWidth, platHeight), -1280, 0),
    Platform:new(Rect:new(platRightOffset, 2176, platWidth, platHeight), -1280, -1016)
}
rightSide.deployRect = Rect:new(6144, 1152, platWidth, platHeight)

----------------------------------
-- Side Buildings
----------------------------------

leftSide.buildings = {
    {unitName = "baseturret", x = 2496, z = 1530, dir = "e", noSelectable = false},
    {unitName = "centerturret", x = 3264, z = 1530, dir = "e", noSelectable = false},
    {unitName = "staticrearm", x = 1550, z = 1226, dir = "e", noSelectable = true},
    {unitName = "staticrearm", x = 1550, z = 1386, dir = "e", noSelectable = true},
    {unitName = "staticrearm", x = 1550, z = 1529, dir = "e", noSelectable = true},
    {unitName = "staticrearm", x = 1550, z = 1703, dir = "e", noSelectable = true},
    {unitName = "staticrearm", x = 1550, z = 1848, dir = "e", noSelectable = true}
}

rightSide.buildings = {
    {unitName = "baseturret", x = 5696, z = 1530, dir = "w", noSelectable = false},
    {unitName = "centerturret", x = 4930, z = 1530, dir = "w", noSelectable = false},
    {unitName = "staticrearm", x = 6641, z = 1226, dir = "w", noSelectable = true},
    {unitName = "staticrearm", x = 6641, z = 1386, dir = "w", noSelectable = true},
    {unitName = "staticrearm", x = 6641, z = 1529, dir = "w", noSelectable = true},
    {unitName = "staticrearm", x = 6641, z = 1703, dir = "w", noSelectable = true},
    {unitName = "staticrearm", x = 6641, z = 1848, dir = "w", noSelectable = true}
}

----------------------------------
-- Player Platform Units
----------------------------------

leftSide.playerUnits = {
    {unitName = "basiccon", x = -140, z = 350, dir = "e", metalIncome = 6, energyIncome = 6},
    {unitName = "chicken_drone_starter", x = -140, z = 350, dir = "e"}
}

rightSide.playerUnits = {
    {unitName = "basiccon", x = 520, z = 410, dir = "w", metalIncome = 6, energyIncome = 6},
    {unitName = "chicken_drone_starter", x = 520, z = 410, dir = "w"}
}

----------------------------------
-- Player Platform customparams
----------------------------------

leftSide.customParams = {
    COMMANDER_SPAWN = {x = 1855, z = 1537}
}

rightSide.customParams = {
    COMMANDER_SPAWN = {x = 6336, z = 1537}
}

return leftSide, rightSide
