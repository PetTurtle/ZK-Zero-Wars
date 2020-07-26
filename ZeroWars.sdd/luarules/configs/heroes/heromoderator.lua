VFS.Include("LuaRules/Configs/customcmds.h.lua")

local heromoderator = {
    onReady = {
        {"Scale", -0.15},
        {"EnableCommand", CMD.MANUALFIRE, false}
    },
    onLevelUp = {
        {"HP", 0.15},
        {"Scale", 0.08}
    },
    path1 = {
        {
            name = "Adv Beamlaser",
            desc = "+50% Damage\n+50% Slow Damage",
            params = {
                {"WeaponDamage", 1, 0.5}
            },
            requiredUpgrades = 0
        },
        {
            name = "Energy Crystal",
            desc = "+50% Damage\n+50% Slow Damage",
            params = {
                {"WeaponDamage", 2, 0.50}
            },
            requiredUpgrades = 1
        },
        {
            name = "Beam Bundling",
            desc = "+50% Damage\n+50% Slow Damage",
            params = {
                {"WeaponDamage", 2, 0.50}
            },
            requiredUpgrades = 4
        },
        {
            name = "Power Crystal",
            desc = "+50% Damage\n+50% Slow Damage",
            params = {
                {"WeaponDamage", 2, 0.50}
            },
            requiredUpgrades = 6
        }
    },
    path2 = {
        {
            name = "Cooling System",
            desc = "+20% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 0
        },
        {
            name = "Adv Circuits",
            desc = "+20% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 1
        },
        {
            name = "Cryo Stabylizer",
            desc = "+20% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 4
        },
        {
            name = "Resonant Conduit",
            desc = "+20% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 6
        }
    },
    path3 = {
        {
            name = "Light Armour",
            desc = "+800 HP",
            params = {
                {"Armour", "800"}
            },
            requiredUpgrades = 0
        },
        {
            name = "Medium Armour",
            desc = "+800 HP",
            params = {
                {"Armour", "800"}
            },
            requiredUpgrades = 1
        },
        {
            name = "Adv Targeting",
            desc = "+15% range",
            params = {
                {"WeaponRange", 1, 0.15}
            },
            requiredUpgrades = 4
        },
        {
            name = "Precision Module",
            desc = "+15%  range",
            params = {
                {"WeaponRange", 1, 0.15}
            },
            requiredUpgrades = 6
        }
    },
    path4 = {
        {
            name = "Disruptor Bomb",
            desc = "Unlock Disruptor Bomb",
            params = {
                {"EnableCommand", CMD.MANUALFIRE, true}
            },
            requiredUpgrades = 6
        },
        {
            name = "Time Distortion",
            desc = "+50% Damage",
            params = {
                {"WeaponDamage", 2, 0.5}
            },
            requiredUpgrades = 8
        },
        {
            name = "Chronomancy",
            desc = "+50% Damage",
            params = {
                {"WeaponDamage", 2, 0.5}
            },
            requiredUpgrades = 10
        },
        {
            name = "Violet Slugger",
            desc = "+50% Damage",
            params = {
                {"WeaponDamage", 2, 0.5}
            },
            requiredUpgrades = 12
        }
    }
}
return "heromoderator", heromoderator
