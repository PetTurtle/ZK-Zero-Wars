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

local platformBuildings = {
    [1] = {
        {unitName = "mextier1", x = -256, z = 240, dir = "e"},
        {unitName = "mextier1", x = -256, z = 336, dir = "e"},
        {unitName = "mextier1", x = -256, z = 432, dir = "e"},
        {unitName = "mextier1", x = -256, z = 528, dir = "e"}
    },
    [2] = {
        {unitName = "mextier1", x = 624, z = 240, dir = "e"},
        {unitName = "mextier1", x = 624, z = 336, dir = "e"},
        {unitName = "mextier1", x = 624, z = 432, dir = "e"},
        {unitName = "mextier1", x = 624, z = 528, dir = "e"}
    }
}

return centerBuildings, platformBuildings