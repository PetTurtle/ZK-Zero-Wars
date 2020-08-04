VFS.Include("LuaRules/Configs/customcmds.h.lua")

local heropuppy = {
    onReady = {
        {"Scale", 0},
        {"EnableCommand", CMD.MANUALFIRE, false},
        {"EnableCommand", CMD_JUMP, false}
    },
    onLevelUp = {
        {"HP", 0.15},
        {"Scale", 0.10}
    },
    path1 = {
        {
            name = "Missile Pods",
            desc = "+30% Damage \n Required Upgrades 0",
            params = {
                {"WeaponDamage", 1, 0.30}
            },
            requiredUpgrades = 0
        },
        {
            name = "HESH Ammo",
            desc = "+30% Damage \n Required Upgrades 1",
            params = {
                {"WeaponDamage", 1, 0.30}
            },
            requiredUpgrades = 1
        },
        {
            name = "Impact Upgrade",
            desc = "+30% Damage \n Required Upgrades 4",
            params = {
                {"WeaponDamage", 1, 0.30}
            },
            requiredUpgrades = 4
        },
        {
            name = "Cluster Grenade",
            desc = "+30% Damage \n Required Upgrades 6",
            params = {
                {"WeaponDamage", 1, 0.30}
            },
            requiredUpgrades = 6
        }
    },
    path2 = {
        {
            name = "Extended Mag",
            desc = "+25% Fire Rate \n Required Upgrades 0",
            params = {
                {"WeaponReload", 1, 0.25}
            },
            requiredUpgrades = 0
        },
        {
            name = "Autoloader",
            desc = "+25% Fire Rate \n Required Upgrades 1",
            params = {
                {"WeaponReload", 1, 0.25}
            },
            requiredUpgrades = 1
        },
        {
            name = "Double Salvo",
            desc = "Two Salvos\n-40% Fire Rate \n Required Upgrades 4",
            params = {
                {"WeaponBurst", 1, 1},
                {"WeaponReload", 1, -0.4}
            },
            requiredUpgrades = 4
        },
        {
            name = "Overdrive",
            desc = "+25% Fire Rate \n Required Upgrades 6",
            params = {
                {"WeaponReload", 1, 0.25}
            },
            requiredUpgrades = 6
        }
    },
    path3 = {
        {
            name = "Jump",
            desc = "Unlock Jump \n Required Upgrades 0",
            params = {
                {"EnableCommand", CMD_JUMP, true}
            },
            requiredUpgrades = 0
        },
        {
            name = "Light Armour",
            desc = "+800 HP \n Required Upgrades 1",
            params = {
                {"Armour", "800"},
                {"Scale", 0.05}
            },
            requiredUpgrades = 1
        },
        {
            name = "Medium Armour",
            desc = "+800 HP \n Required Upgrades 4",
            params = {
                {"Armour", "800"},
                {"Scale", 0.05}
            },
            requiredUpgrades = 4
        },
        {
            name = "Ultimate Armour",
            desc = "+800 HP \n Required Upgrades 6",
            params = {
                {"Armour", "800"},
                {"Scale", 0.05}
            },
            requiredUpgrades = 6
        }
    },
    path4 = {
        {
            name = "Puppy Gun",
            desc = "Unlock Puppy Gun \n Required Upgrades 6",
            params = {
                {"EnableCommand", CMD.MANUALFIRE, true}
            },
            requiredUpgrades = 6
        },
        {
            name = "Flock of Puppies",
            desc = "+2 Puppies \n Required Upgrades 8",
            params = {
                {"WeaponBurst", 2, 2}
            },
            requiredUpgrades = 8
        },
        {
            name = "Herd of Puppies",
            desc = "+2 Puppies \n Required Upgrades 10",
            params = {
                {"WeaponBurst", 2, 2}
            },
            requiredUpgrades = 10
        },
        {
            name = "Puppy Army",
            desc = "+4 Puppies \n Required Upgrades 12",
            params = {
                {"WeaponBurst", 2, 4}
            },
            requiredUpgrades = 12
        }
    }
}
return "heropuppy", heropuppy
