VFS.Include("LuaRules/Configs/customcmds.h.lua")

local herodante = {
    onReady = {
        {"Scale", -0.15},
        {"WeaponRange", 1, -1},
        {"WeaponRange", 2, -1},
        {"EnableCommand", CMD.MANUALFIRE, false}
    }, 
    onLevelUp = {
        {"HP", 0.13},
        {"Scale", 0.04}
    },
    path1 = {
        {
            name = "Fire Rockets",
            desc = "Unlock Fire Rockets",
            params = {
                {"WeaponRange", 1, 1}
            },
            requiredUpgrades = 0
        },
        {
            name = "Advanced Explosives",
            desc = "+20% Rocket Damage",
            params = {
                {"WeaponDamage", 2, 0.20}
            },
            requiredUpgrades = 1
        },
        {
            name = "Quadra Rockets",
            desc = "+2 Rockets",
            params = {
                {"WeaponBurst", 1, 2}
            },
            requiredUpgrades = 4
        },
        {
            name = "Hell Fire",
            desc = "+20% Rocket Damage",
            params = {
                {"WeaponDamage", 1, 0.20}
            },
            requiredUpgrades = 6
        }
    },
    path2 = {
        {
            name = "Double Heatray",
            desc = "Unlock Heatray",
            params = {
                {"WeaponRange", 2, 1}
            },
            requiredUpgrades = 0
        },
        {
            name = "Heat Core",
            desc = "+15% Damage",
            params = {
                {"WeaponDamage", 2, 0.15}
            },
            requiredUpgrades = 1
        },
        {
            name = "Heat Pipelines",
            desc = "+15% Damage\n+20% Movement Speed",
            params = {
                {"WeaponDamage", 2, 0.2},
                {"MoveSpeed", 0.15}
            },
            requiredUpgrades = 4
        },
        {
            name = "Sun Core",
            desc = "+15% Damage\n+20% Movement Speed",
            params = {
                {"WeaponDamage", 2, 0.2},
                {"MoveSpeed", 0.15}
            },
            requiredUpgrades = 6
        }
    },
    path3 = {
        {
            name = "Faster Repair",
            desc = "+25% Faster Regen Time",
            params = {
                {"IdleRegen", -0.25, 0}
            },
            requiredUpgrades = 0
        },
        {
            name = "Medium Repair",
            desc = "+15% Regen Amount",
            params = {
                {"IdleRegen", 0, 0.15}
            },
            requiredUpgrades = 1
        },
        {
            name = "Enhanced Repair",
            desc = "+15% Faster Regen Time\n+10% Regen Amount",
            params = {
                {"IdleRegen", -0.15, 0.10}
            },
            requiredUpgrades = 4
        },
        {
            name = "Ultimate Repair",
            desc = "+15% Faster Regen Time\n+10% Regen Amount",
            params = {
                {"IdleRegen", -0.15, 0.1}
            },
            requiredUpgrades = 6
        }
    },
    path4 = {
        {
            name = "Rocket Salvo",
            desc = "Unlock Rocket Salvo",
            params = {
                {"EnableCommand", CMD.MANUALFIRE, true}
            },
            requiredUpgrades = 6
        },
        {
            name = "Extra Rockets",
            desc = "+5 Rockets",
            params = {
                {"WeaponBurst", 3, 5}
            },
            requiredUpgrades = 8
        },
        {
            name = "Rocket Swarm",
            desc = "+5 Rockets",
            params = {
                {"WeaponBurst", 3, 5}
            },
            requiredUpgrades = 10
        },
        {
            name = "Rocket Armada",
            desc = "+5 Rockets",
            params = {
                {"WeaponBurst", 3, 5}
            },
            requiredUpgrades = 12
        }
    }
}
return "herodante", herodante
