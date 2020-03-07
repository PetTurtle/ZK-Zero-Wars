Spring.GetModOptions = Spring.GetModOptions or function() return {} end

local customUpgradeDefs = {
    CMD_CUSTOM_UPGRADE = 49731,
    CMD_CUSTOM_MINIONSPAWN = 49732,

    comduck = {
        path1 = {
            [1] = { name = "Basic Missiles", desc = "+dmg +aoe",},
            [2] = { name = "Advanced Missiles", desc = "+dmg +aoe", },
            [3] = { name = "Super Missiles", desc = "+dmg +aoe", },
            [4] = { name = "Ultimate Missiles", desc = "+dmg +aoe", },
        },
        path2 = {
            [1] = { name = "Mini Lazer", desc = "good for single target damage", },
            [2] = { name = "Lazer Damage", desc = "+dmg -rate of fire", },
            [3] = { name = "Lazer Damage", desc = "+dmg -rate of fire", },
            [4] = { name = "Lazer Damage", desc = "+dmg -rate of fire", },
        },
        path3 = {
            [1] = { name = "Light Armour", desc = "Adds 500 HP", },
            [2] = { name = "Medium Armour", desc = "Adds 1000 HP", },
            [3] = { name = "Heavy Armour", desc = "Adds 1500 HP", },
            [4] = { name = "Cloak", desc = "Gives Cloak", },
        },
        path4 = {
            [1] = { name = "MINI S.L.A.M.", desc = "to be added", },
            [2] = { name = "S.L.A.M. Burst", desc = "to be added", },
            [3] = { name = "S.L.A.M. Assault", desc = "to be added", },
            [4] = { name = "S.L.A.M. Sky", desc = "to be added", },
        },
    },
}

return customUpgradeDefs