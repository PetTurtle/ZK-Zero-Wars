VFS.Include("LuaRules/Configs/customcmds.h.lua")

local heroknight = {
    onReady = {
        {"Scale", -0.05},
        {"EnableCommand", CMD.MANUALFIRE, false}
    },
    onLevelUp = {
        {"HP", 0.1},
        {"Scale", 0.05}
    },
    path1 = {
        {
            name = "Plasma Upgrade",
            desc = "+25% Damage",
            params = {
                {"WeaponDamage", 1, 0.25}
            },
            requiredUpgrades = 0
        },
        {
            name = "Ionized plasma",
            desc = "+25% Damage",
            params = {
                {"WeaponDamage", 1, 0.25}
            },
            requiredUpgrades = 1
        },
        {
            name = "Tesla Upgrade",
            desc = "+25% Damage",
            params = {
                {"WeaponDamage", 1, 0.25}
            },
            requiredUpgrades = 4
        },
        {
            name = "Sun Core",
            desc = "+25% Damage",
            params = {
                {"WeaponDamage", 1, 0.25}
            },
            requiredUpgrades = 6
        }
    },
    path2 = {
        {
            name = "Lazer Cooling",
            desc = "+15% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.15}
            },
            requiredUpgrades = 0
        },
        {
            name = "Heat Pipes",
            desc = "+15% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.15}
            },
            requiredUpgrades = 1
        },
        {
            name = "Nitrogen Tank",
            desc = "+15% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.15}
            },
            requiredUpgrades = 4
        },
        {
            name = "Sub Zero",
            desc = "+15% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.15}
            },
            requiredUpgrades = 6
        }
    },
    path3 = {
        {
            name = "Light Armour",
            desc = "+1500 HP",
            params = {
                {"Armour", "1500"}
            },
            requiredUpgrades = 0
        },
        {
            name = "Medium Armour",
            desc = "+1500 HP",
            params = {
                {"Armour", "1500"}
            },
            requiredUpgrades = 1
        },
        {
            name = "Heavy Armour",
            desc = "+1500 HP",
            params = {
                {
                    "Armour",
                    "1500"
                }
            },
            requiredUpgrades = 4
        },
        {
            name = "Ultimate Armour",
            desc = "+1500 HP",
            params = {
                {
                    "Armour",
                    "1500"
                }
            },
            requiredUpgrades = 6
        }
    },
    path4 = {
        {
            name = "Gauss Blast",
            desc = "Unlock Gauss Blast",
            params = {
                {"EnableCommand", CMD.MANUALFIRE, true}
            },
            requiredUpgrades = 6
        },
        {
            name = "Extra Gauss",
            desc = "+1 Burst",
            params = {
                {"WeaponBurst", 2, 1}
            },
            requiredUpgrades = 8
        },
        {
            name = "Gauss Array",
            desc = "+1 Burst",
            params = {
                {"WeaponBurst", 2, 1}
            },
            requiredUpgrades = 10
        },
        {
            name = "Recursive Gauss",
            desc = "+2 Burst",
            params = {
                {"WeaponBurst", 2, 2}
            },
            requiredUpgrades = 12
        }
    }
}
return "heroknight", heroknight
