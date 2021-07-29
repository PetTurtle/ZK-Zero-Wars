local WIDTH = 368
local HEIGHT = 752
local MAPWIDTH = Game.mapSizeX

local PADDINGLEFT = 384
local PADDINGRIGHT = MAPWIDTH - WIDTH - PADDINGLEFT - 16

local PLATFORM1 = 128
local PLATFORM2 = 1152
local PLATFORM3 = 2176

local MEXXOFFSET = 0.7

local config = {
  Left = {
    faceDir = "e",
    attackPosX = 5888,
    deployRect = { x = 1664, z = 1152, width = WIDTH, height = HEIGHT },
    nexus = { x = 2496, z = 1530 },
    nexusTurret = { x = 3264, z = 1530 },
    extraBuildings = {
      { unitName = "staticrearm", x = 1550, z = 1226 },
      { unitName = "staticrearm", x = 1550, z = 1386 },
      { unitName = "staticrearm", x = 1550, z = 1529 },
      { unitName = "staticrearm", x = 1550, z = 1703 },
      { unitName = "staticrearm", x = 1550, z = 1848 },
    },
    platforms = {
      { x = PADDINGLEFT, z = PLATFORM1, width = WIDTH, height = HEIGHT },
      { x = PADDINGLEFT, z = PLATFORM2, width = WIDTH, height = HEIGHT },
      { x = PADDINGLEFT, z = PLATFORM3, width = WIDTH, height = HEIGHT },
    },
    mex = {
      { x = -WIDTH * MEXXOFFSET, z = HEIGHT * 0.1 },
      { x = -WIDTH * MEXXOFFSET, z = HEIGHT * 0.5 },
      { x = -WIDTH * MEXXOFFSET, z = HEIGHT * 0.9 }
    }
  },
  Right = {
    faceDir = "w",
    attackPosX = 2303,
    deployRect = { x = 6144, z = 1152, width = WIDTH, height = HEIGHT },
    nexus = { x = 5696, z = 1530 },
    nexusTurret = { x = 4930, z = 1530 },
    extraBuildings = {
      { unitName = "staticrearm", x = 6641, z = 1226 },
      { unitName = "staticrearm", x = 6641, z = 1386 },
      { unitName = "staticrearm", x = 6641, z = 1529 },
      { unitName = "staticrearm", x = 6641, z = 1703 },
      { unitName = "staticrearm", x = 6641, z = 1848 },
    },
    platforms = {
      { x = PADDINGRIGHT, z = PLATFORM1, width = WIDTH, height = HEIGHT },
      { x = PADDINGRIGHT, z = PLATFORM2, width = WIDTH, height = HEIGHT },
      { x = PADDINGRIGHT, z = PLATFORM3, width = WIDTH, height = HEIGHT },
    },
    mex = {
      { x = WIDTH + (WIDTH * MEXXOFFSET), z = HEIGHT * 0.1 },
      { x = WIDTH + (WIDTH * MEXXOFFSET), z = HEIGHT * 0.5 },
      { x = WIDTH + (WIDTH * MEXXOFFSET), z = HEIGHT * 0.9 }
    }
  }
}

return config
