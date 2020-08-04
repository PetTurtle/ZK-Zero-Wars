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
            desc = "+35% Damage\n+35% Slow Damage \n Required Upgrades 0",
            params = {
                {"WeaponDamage", 1, 0.35}
            },
            requiredUpgrades = 0
        },
        {
            name = "Energy Crystal",
            desc = "+35% Damage\n+35% Slow Damage \n Required Upgrades 1",
            params = {
                {"WeaponDamage", 1, 0.35}
            },
            requiredUpgrades = 1
        },
        {
            name = "Beam Bundling",
            desc = "+35% Damage\n+35% Slow Damage \n Required Upgrades 4",
            params = {
                {"WeaponDamage", 1, 0.35}
            },
            requiredUpgrades = 4
        },
        {
            name = "Power Crystal",
            desc = "+35% Damage\n+35% Slow Damage \n Required Upgrades 6",
            params = {
                {"WeaponDamage", 1, 0.35}
            },
            requiredUpgrades = 6
        }
    },
    path2 = {
        {
            name = "Cooling System",
            desc = "+25% Fire Rate \n Required Upgrades 0",
            params = {
                {"WeaponReload", 1, 0.25}
            },
            requiredUpgrades = 0
        },
        {
            name = "Adv Circuits",
            desc = "+25% Fire Rate \n Required Upgrades 1",
            params = {
                {"WeaponReload", 1, 0.25}
            },
            requiredUpgrades = 1
        },
        {
            name = "Cryo Stabylizer",
            desc = "+25% Fire Rate \n Required Upgrades 4",
            params = {
                {"WeaponReload", 1, 0.25}
            },
            requiredUpgrades = 4
        },
        {
            name = "Resonant Conduit",
            desc = "+25% Fire Rate \n Required Upgrades 6",
            params = {
                {"WeaponReload", 1, 0.25}
            },
            requiredUpgrades = 6
        }
    },
    path3 = {
        {
            name = "Light Armour",
            desc = "+800 HP \n Required Upgrades 0",
            params = {
                {"Armour", "800"}
            },
            requiredUpgrades = 0
        },
        {
            name = "Medium Armour",
            desc = "+800 HP \n Required Upgrades 1",
            params = {
                {"Armour", "800"}
            },
            requiredUpgrades = 1
        },
        {
            name = "Adv Targeting",
            desc = "+15% range \n Required Upgrades 4",
            params = {
                {"WeaponRange", 1, 0.15}
            },
            requiredUpgrades = 4
        },
        {
            name = "Precision Module",
            desc = "+15%  range \n Required Upgrades 6",
            params = {
                {"WeaponRange", 1, 0.15}
            },
            requiredUpgrades = 6
        }
    },
    path4 = {
        {
            name = "Disruptor Bomb",
            desc = "Unlock Disruptor Bomb \n Required Upgrades 6",
            params = {
                {"EnableCommand", CMD.MANUALFIRE, true}
            },
            requiredUpgrades = 6
        },
        {
            name = "Time Distortion",
            desc = "+50% Damage \n Required Upgrades 8",
            params = {
                {"WeaponDamage", 2, 0.5}
            },
            requiredUpgrades = 8
        },
        {
            name = "Chronomancy",
            desc = "+50% Damage \n Required Upgrades 10",
            params = {
                {"WeaponDamage", 2, 0.5}
            },
            requiredUpgrades = 10
        },
        {
            name = "Violet Slugger",
            desc = "+50% Damage \n Required Upgrades 12",
            params = {
                {"WeaponDamage", 2, 0.5}
            },
            requiredUpgrades = 12
        }
    }
}
return "heromoderator", heromoderator
