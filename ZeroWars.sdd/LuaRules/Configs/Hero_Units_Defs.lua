Spring.GetModOptions = Spring.GetModOptions or function() return {} end

local HeroUpgradeDefs = {
    CMD_HERO_UPGRADE = 49731,

    heroreaver = {
        path1 = {
            [1] = { name = "Dual Missile Pods", desc = "Adds Second Missile Burst",},
            [2] = { name = "Advanced Missiles", desc = "More Damage, Adds Another Missile Burst", },
            [3] = { name = "Super Missiles", desc = "More Damage, Adds Another Missile Burst", },
            [4] = { name = "Ultimate Missiles", desc = "More Damage", },
        },
        path2 = {
            [1] = { name = "Mini Lazer", desc = "good for single target damage", },
            [2] = { name = "Advanced Lazer", desc = "more damage", },
            [3] = { name = "Super Lazer", desc = "more damage", },
            [4] = { name = "Ultimate Lazer", desc = "more damage", },
        },
        path3 = {
            [1] = { name = "Light Armour", desc = "Adds 1000 HP", },
            [2] = { name = "Medium Armour", desc = "Adds 2000 HP", },
            [3] = { name = "Heavy Armour", desc = "Adds 3000 HP", },
            [4] = { name = "Ultimate Armour", desc = "Adds 5000 HP", },
        },
        path4 = {
            [1] = { name = "MINI S.L.A.M.", desc = "4 mini slam burst", },
            [2] = { name = "S.L.A.M. Burst", desc = "6 mini slam burst", },
            [3] = { name = "S.L.A.M. Assault", desc = "8 mini slam burst", },
            [4] = { name = "S.L.A.M. Barrage", desc = "12 mini slam burst", },
        },
    },
}


local platWidth = 368
local platHeight = 752
local AllyTeamLayouts = {
    [1] = {
        spawnPoint = {x = 1664 + platWidth/2, z = 1152 + platHeight/2}
    },
    [2] = {
        spawnPoint = {x = 6144 + platWidth/2, z = 1152 + platHeight/2}
    }
}

return HeroUpgradeDefs, AllyTeamLayouts

-- hp regen
-- dash
-- jump
-- aoe stun
-- temp dmg / regen / speed boost
-- push units
-- launch into air
-- slow
-- teleport
-- summon minions
-- mind control clones
-- healing
-- more range
-- more dmg
-- temp immune
-- knock back
-- knock forward
-- invisable
-- plant mine
-- summon missile
-- shotgun blast
-- burst attack
-- storm / barrage