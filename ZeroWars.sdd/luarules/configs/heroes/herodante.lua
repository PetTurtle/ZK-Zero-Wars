VFS.Include("LuaRules/Configs/customcmds.h.lua")

local herodante = {
    onReady = {
        {"Scale", -0.15},
        {"WeaponRange", 1, -1},
        {"WeaponRange", 2, -1},
        {"EnableCommand", CMD.MANUALFIRE, false}
    }, 
    onLevelUp = {
        {"HP", 0.20},
        {"Scale", 0.04}
    },
    path1 = {
        {
            name = "Fire Rockets",
            desc = "Unlock Fire Rockets \n Required Upgrades 0",
            params = {
                {"WeaponRange", 1, 1}
            },
            requiredUpgrades = 0
        },
        {
            name = "Advanced Explosives",
            desc = "+25% Rocket Damage \n Required Upgrades 1",
            params = {
                {"WeaponDamage", 2, 0.25}
            },
            requiredUpgrades = 1
        },
        {
            name = "Quadra Rockets",
            desc = "+2 Rockets \n Required Upgrades 4",
            params = {
                {"WeaponBurst", 1, 2}
            },
            requiredUpgrades = 4
        },
        {
            name = "Hell Fire",
            desc = "+25% Rocket Damage \n Required Upgrades 6",
            params = {
                {"WeaponDamage", 1, 0.25}
            },
            requiredUpgrades = 6
        }
    },
    path2 = {
        {
            name = "Double Heatray",
            desc = "Unlock Heatray \n Required Upgrades 0",
            params = {
                {"WeaponRange", 2, 1}
            },
            requiredUpgrades = 0
        },
        {
            name = "Heat Core",
            desc = "+15% Damage \n Required Upgrades 1",
            params = {
                {"WeaponDamage", 2, 0.15}
            },
            requiredUpgrades = 1
        },
        {
            name = "Heat Pipelines",
            desc = "+15% Damage\n+20% Movement Speed \n Required Upgrades 4",
            params = {
                {"WeaponDamage", 2, 0.2},
                {"MoveSpeed", 0.15}
            },
            requiredUpgrades = 4
        },
        {
            name = "Sun Core",
            desc = "+15% Damage\n+20% Movement Speed \n Required Upgrades 6",
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
            desc = "+25% Faster Regen Time \n Required Upgrades 0",
            params = {
                {"IdleRegen", -0.25, 0}
            },
            requiredUpgrades = 0
        },
        {
            name = "Medium Repair",
            desc = "+10% Faster Regen Time\n+10% Regen Amount \n Required Upgrades 1",
            params = {
                {"IdleRegen", -0.10, 0.10}
            },
            requiredUpgrades = 1
        },
        {
            name = "Enhanced Repair",
            desc = "+10% Faster Regen Time\n+10% Regen Amount \n Required Upgrades 4",
            params = {
                {"IdleRegen", -0.10, 0.10}
            },
            requiredUpgrades = 4
        },
        {
            name = "Ultimate Repair",
            desc = "+15% Faster Regen Time\n+10% Regen Amount \n Required Upgrades 6",
            params = {
                {"IdleRegen", -0.15, 0.1}
            },
            requiredUpgrades = 6
        }
    },
    path4 = {
        {
            name = "Rocket Salvo",
            desc = "Unlock Rocket Salvo \n Required Upgrades 6",
            params = {
                {"EnableCommand", CMD.MANUALFIRE, true}
            },
            requiredUpgrades = 6
        },
        {
            name = "Extra Rockets",
            desc = "+12 Rockets \n Required Upgrades 8",
            params = {
                {"WeaponBurst", 3, 6}
            },
            requiredUpgrades = 8
        },
        {
            name = "Rocket Swarm",
            desc = "+12 Rockets \n Required Upgrades 10",
            params = {
                {"WeaponBurst", 3, 6}
            },
            requiredUpgrades = 10
        },
        {
            name = "Rocket Armada",
            desc = "+12 Rockets \n Required Upgrades 12",
            params = {
                {"WeaponBurst", 3, 6}
            },
            requiredUpgrades = 12
        }
    }
}
return "herodante", herodante
