VFS.Include("LuaRules/Configs/customcmds.h.lua")

local herosniper = {
    onReady = {
        {"Scale", -0.05},
        {"EnableCommand", CMD.MANUALFIRE, false}
    },
    onLevelUp = {
        {"HP", 0.25},
        {"Scale", 0.05}
    },
    path1 = {
        {
            name = "Higher Calibre",
            desc = "+50% Damage",
            params = {
                {"WeaponDamage", 1, 0.5}
            },
            requiredUpgrades = 0
        },
        {
            name = "Shrapnel",
            desc = "+60% AOE",
            params = {
                {"WeaponAOE", 1, 0.6}
            },
            requiredUpgrades = 1
        },
        {
            name = "Improved Percing",
            desc = "+50% Damage",
            params = {
                {"WeaponDamage", 1, 0.5}
            },
            requiredUpgrades = 4
        },
        {
            name = "Improved Piercing",
            desc = "+50% Damage",
            params = {
                {"WeaponDamage", 1, 0.5}
            },
            requiredUpgrades = 6
        }
    },
    path2 = {
        {
            name = "Extended Mag",
            desc = "+20% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 0
        },
        {
            name = "Improved Firerate",
            desc = "+20% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 1
        },
        {
            name = "Semi-Automatic",
            desc = "+20% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 4
        },
        {
            name = "Belt-Fed",
            desc = "+20% Fire Rate",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 6
        }
    },
    path3 = {
        {
            name = "Improved Servo",
            desc = "+20% Movement Speed",
            params = {
                {"MoveSpeed", "0.20"}
            },
            requiredUpgrades = 0
        },
        {
            name = "Advanced Motors",
            desc = "+20% Movement Speed",
            params = {
                {"MoveSpeed", "0.20"}
            },
            requiredUpgrades = 1
        },
        {
            name = "Industrial Motors",
            desc = "+20% Movement Speed",
            params = {
                {"MoveSpeed", "0.20"}
            },
            requiredUpgrades = 4
        },
        {
            name = "Experimental Servo",
            desc = "+20% Movement Speed",
            params = {
                {"MoveSpeed", "0.20"}
            },
            requiredUpgrades = 6
        }
    },
    path4 = {
        {
            name = "Shock Rifle",
            desc = "Unlock Shock Rifle",
            params = {
                {"EnableCommand", CMD.MANUALFIRE, true}
            },
            requiredUpgrades = 6
        },
        {
            name = "Higher Calibre",
            desc = "+35% Damage",
            params = {
                {"WeaponDamage", 2, 0.35}
            },
            requiredUpgrades = 8
        },
        {
            name = "H.E.A.T Ammo",
            desc = "+35% Damage",
            params = {
                {"WeaponDamage", 2, 0.35}
            },
            requiredUpgrades = 10
        },
        {
            name = "Max Calibre",
            desc = "+35% Damage",
            params = {
                {"WeaponDamage", 2, 0.35}
            },
            requiredUpgrades = 12
        }
    }
}
return "herosniper", herosniper
