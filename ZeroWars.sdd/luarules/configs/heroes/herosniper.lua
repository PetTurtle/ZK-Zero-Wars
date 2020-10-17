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
            desc = "+25% Damage \n Required Upgrades 0",
            params = {
                {"WeaponDamage", 1, 0.25}
            },
            requiredUpgrades = 0
        },
        {
            name = "Shrapnel",
            desc = "+25% AOE \n Required Upgrades 1",
            params = {
                {"WeaponAOE", 1, 0.25}
            },
            requiredUpgrades = 1
        },
        {
            name = "Improved Percing",
            desc = "+25% Damage \n Required Upgrades 4",
            params = {
                {"WeaponDamage", 1, 0.25}
            },
            requiredUpgrades = 4
        },
        {
            name = "Improved Piercing",
            desc = "+25% Damage \n Required Upgrades 6",
            params = {
                {"WeaponDamage", 1, 0.25}
            },
            requiredUpgrades = 6
        }
    },
    path2 = {
        {
            name = "Extended Mag",
            desc = "+20% Fire Rate \n Required Upgrades 0",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 0
        },
        {
            name = "Improved Firerate",
            desc = "+20% Fire Rate \n Required Upgrades 1",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 1
        },
        {
            name = "Semi-Automatic",
            desc = "+20% Fire Rate \n Required Upgrades 4",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 4
        },
        {
            name = "Belt-Fed",
            desc = "+20% Fire Rate \n Required Upgrades 6",
            params = {
                {"WeaponReload", 1, 0.2}
            },
            requiredUpgrades = 6
        }
    },
    path3 = {
        {
            name = "Improved Servo",
            desc = "+20% Movement Speed \n Required Upgrades 0",
            params = {
                {"MoveSpeed", "0.20"}
            },
            requiredUpgrades = 0
        },
        {
            name = "Advanced Motors",
            desc = "+20% Movement Speed \n Required Upgrades 1",
            params = {
                {"MoveSpeed", "0.20"}
            },
            requiredUpgrades = 1
        },
        {
            name = "Industrial Motors",
            desc = "+20% Movement Speed \n Required Upgrades 4",
            params = {
                {"MoveSpeed", "0.20"}
            },
            requiredUpgrades = 4
        },
        {
            name = "Experimental Servo",
            desc = "+20% Movement Speed \n Required Upgrades 6",
            params = {
                {"MoveSpeed", "0.20"}
            },
            requiredUpgrades = 6
        }
    },
    path4 = {
        {
            name = "Paralyze Rifle",
            desc = "Unlock Shock Rifle \n Required Upgrades 6",
            params = {
                {"EnableCommand", CMD.MANUALFIRE, true}
            },
            requiredUpgrades = 6
        },
        {
            name = "Higher Calibre",
            desc = "+40% Paralyze Time \n +25% AOE \n Required Upgrades 8",
            params = {
                {"WeaponParalyzeTime", 2, 0.40},
                {"WeaponAOE", 2, 0.25}
            },
            requiredUpgrades = 8
        },
        {
            name = "H.E.A.T Ammo",
            desc = "+40% Paralyze Time \n +25% AOE \n Required Upgrades 10",
            params = {
                {"WeaponParalyzeTime", 2, 0.40},
                {"WeaponAOE", 2, 0.25}
            },
            requiredUpgrades = 10
        },
        {
            name = "Max Calibre",
            desc = "+40% Paralyze Time \n +25% AOE \n Required Upgrades 12",
            params = {
                {"WeaponParalyzeTime", 2, 0.40},
                {"WeaponAOE", 2, 0.25}
            },
            requiredUpgrades = 12
        }
    }
}
return "herosniper", herosniper
