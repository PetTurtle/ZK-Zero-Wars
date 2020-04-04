local layout = {
    [1] = {},
    [2] = {}
}

local gY = 128 -- global y pos
local gZ = 1530 -- global z pos
local gDroneName = "chicken_drone_starter" -- global starter drone unit

layout[1].spawnPoint = {x = 1855, y = gY, z = gZ}
layout[1].respawnPoint = {x = 1085, y = gY, z = gZ}
layout[1].droneParams = {name = gDroneName, x = 1085, y = gY, z = gZ, faceDir = "e"}

layout[2].spawnPoint = {x = 6335, y = gY, z = gZ}
layout[2].respawnPoint = {x = 7100, y = gY, z = gZ}
layout[2].droneParams = {name = gDroneName, x = 7100, y = gY, z = gZ, faceDir = "w"}

return layout
