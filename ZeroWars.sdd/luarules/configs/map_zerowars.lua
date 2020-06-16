local Rect = VFS.Include("luarules/gadgets/util/rect.lua")

local width = 368
local height = 752

local leftX = 384
local rightX = Game.mapSizeX - width - leftX - 16

local y1 = 128
local y2 = 1152
local y3 = 2176

local platforms = {
    Left = {
        [1] = Rect.new(leftX, y1, width, height),
        [2] = Rect.new(leftX, y2, width, height),
        [3] = Rect.new(leftX, y3, width, height)
    },
    Right = {
        [1] = Rect.new(rightX, y1, width, height),
        [2] = Rect.new(rightX, y2, width, height),
        [3] = Rect.new(rightX, y3, width, height)
    }
}

local deployRects = {
    Left =  Rect.new(1664, 1152, width, height),
    Right = Rect.new(6144, 1152, width, height)
}

local buildings = {
    Left = {
        {unitName = "nexus", x = 2496, z = 1530, dir = "e", endGame = true, notBlocking = true},
        {unitName = "nexusturret", x = 3264, z = 1530, dir = "e", killReward = 800, notBlocking = true},
        {unitName = "staticrearm", x = 1550, z = 1226, dir = "e", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 1550, z = 1386, dir = "e", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 1550, z = 1529, dir = "e", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 1550, z = 1703, dir = "e", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 1550, z = 1848, dir = "e", noSelectable = true, neutral = true}
    },
    Right = {
        {unitName = "nexus", x = 5696, z = 1530, dir = "w", endGame = true, notBlocking = true},
        {unitName = "nexusturret", x = 4930, z = 1530, dir = "w", killReward = 800, notBlocking = true},
        {unitName = "staticrearm", x = 6641, z = 1226, dir = "w", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 6641, z = 1386, dir = "w", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 6641, z = 1529, dir = "w", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 6641, z = 1703, dir = "w", noSelectable = true, neutral = true},
        {unitName = "staticrearm", x = 6641, z = 1848, dir = "w", noSelectable = true, neutral = true}
    }
}

local sideData = {
    Left = {
        faceDir = "e",
        attackX = 5888,
        deployRect = Rect.new(1664, 1152, width, height)
    },
    Right = {
        faceDir = "w",
        attackX = 2303,
        deployRect = Rect.new(6144, 1152, width, height)
    }
}

return platforms, deployRects, buildings, sideData
