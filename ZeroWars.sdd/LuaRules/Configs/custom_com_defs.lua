Spring.GetModOptions = Spring.GetModOptions or function() return {} end

local customUpgradeDefs = {
    comduck = {
        path1 = {
            [1] = { name = "Basic Missiles", desc = "upgrade", },
            [2] = { name = "Advanced Missiles", desc = "upgrade", },
            [3] = { name = "Better Missiles", desc = "upgrade", },
            [4] = { name = "level4", desc = "upgrade", },
        },
        path2 = {
            [1] = { name = "Basic Lazer", desc = "upgrade", },
            [2] = { name = "level2", desc = "upgrade", },
            [3] = { name = "level3", desc = "upgrade", },
            [4] = { name = "level4", desc = "upgrade", },
        },
        path3 = {
            [1] = { name = "Nano Regen", desc = "upgrade", },
            [2] = { name = "level2", desc = "upgrade", },
            [3] = { name = "level3", desc = "upgrade", },
            [4] = { name = "level4", desc = "upgrade", },
        },
        path4 = {
            [1] = { name = "Duck Invasion", desc = "upgrade", },
            [2] = { name = "level2", desc = "upgrade", },
            [3] = { name = "level3", desc = "upgrade", },
            [4] = { name = "level4", desc = "upgrade", },
        },
    },
}

return customUpgradeDefs