VFS.Include("LuaRules/Configs/customcmds.h.lua")

local HeroDefs = {
    heroknight = {
        onReady = {{"Scale", -0.05}},
        onLevelUp = {{"HP", 0.1}, {"Scale", 0.05}},
        path1 = {
            {
                name = "Plasma Upgrade",
                desc = "+50% dmg",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 0
            }, {
                name = "Ionized plasma",
                desc = "+50% dmg",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 1
            }, {
                name = "Tesla Upgrade",
                desc = "+50% dmg",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 4
            }, {
                name = "Sun Core",
                desc = "+50% dmg",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 6
            }
        },
        path2 = {
            {
                name = "Lazer Cooling",
                desc = "+10% fire rate",
                params = {{"WeaponReload", 1, 0.1}},
                requiredUpgrades = 0
            }, {
                name = "Heat Pipes",
                desc = "+15% fire rate",
                params = {{"WeaponReload", 1, 0.15}},
                requiredUpgrades = 1
            }, {
                name = "Nitrogen Tank",
                desc = "+25% fire rate",
                params = {{"WeaponReload", 1, 0.25}},
                requiredUpgrades = 4
            }, {
                name = "Sub Zero",
                desc = "+25% fire rate",
                params = {{"WeaponReload", 1, 0.25}},
                requiredUpgrades = 6
            }
        },
        path3 = {
            {
                name = "Light Armour",
                desc = "+2000 HP",
                params = {{"Armour", "2000"}},
                requiredUpgrades = 0
            }, {
                name = "Medium Armour",
                desc = "+2000 HP",
                params = {{"Armour", "2000"}},
                requiredUpgrades = 1

            }, {
                name = "Heavy Armour",
                desc = "+2000 HP",
                params = {{"Armour", "2000"}},
                requiredUpgrades = 4
            }, {
                name = "Ultimate Armour",
                desc = "+2000 HP",
                params = {{"Armour", "2000"}},
                requiredUpgrades = 6
            }
        },
        path4 = {
            {
                name = "Gauss Blast",
                desc = "Pierces units in a line",
                params = {{"EnableCommand", CMD.MANUALFIRE, true}},
                requiredUpgrades = 0
            }, {
                name = "Extra Gauss",
                desc = "2 bursts",
                params = {{"WeaponBurst", 2, 1}},
                requiredUpgrades = 1
            }, {
                name = "Gauss Array",
                desc = "3 bursts",
                params = {{"WeaponBurst", 2, 1}},
                requiredUpgrades = 4
            }, {
                name = "Recursive Gauss",
                desc = "5 bursts",
                params = {{"WeaponBurst", 2, 2}},
                requiredUpgrades = 6
            }
        }
    },
    heroduck = {
        onReady = {{"Scale", -0.05}},
        onLevelUp = {{"HP", 0.15}, {"Scale", 0.05}},
        path1 = {
            {
                name = "Heavy Grenade",
                desc = "+50% dmg",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 0
            }, {
                name = "HESH Ammo",
                desc = "+25% aoe",
                params = {{"WeaponAOE", 1, 0.25}},
                requiredUpgrades = 1
            }, {
                name = "Impact Upgrade",
                desc = "+50% dmg",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 4
            }, {
                name = "Cluster Grenade",
                desc = "+25% aoe",
                params = {{"WeaponAOE", 1, 0.25}},
                requiredUpgrades = 6
            }
        },
        path2 = {
            {
                name = "Extended Mag",
                desc = "+25% Fire Rate",
                params = {{"WeaponReload", 1, 0.25}},
                requiredUpgrades = 0
            }, {
                name = "Autoloader",
                desc = "+25% Fire Rate",
                params = {{"WeaponReload", 1, 0.25}},
                requiredUpgrades = 1
            }, {
                name = "Double Salvo",
                desc = "Two Salvos",
                params = {{"WeaponBurst", 1, 1}, {"WeaponReload", 1, -0.5}},
                requiredUpgrades = 4
            }, {
                name = "Liquid Cooling",
                desc = "+30% Fire Rate",
                params = {{"WeaponReload", 1, 0.3}},
                requiredUpgrades = 6
            }
        },
        path3 = {
            {
                name = "Light Armour",
                desc = "+1000 HP",
                params = {{"Armour", "1000"}},
                requiredUpgrades = 0
            }, {
                name = "Medium Armour",
                desc = "+1000 HP",
                params = {{"Armour", "1000"}},
                requiredUpgrades = 1
            }, {
                name = "Heavy Armour",
                desc = "+1000 HP",
                params = {{"Armour", "1000"}},
                requiredUpgrades = 4
            }, {
                name = "Ultimate Armour",
                desc = "+2000 HP",
                params = {{"Armour", "2000"}},
                requiredUpgrades = 6
            }
        },
        path4 = {
            {
                name = "E.M.P Blast",
                desc = "Unlock E.M.P Blast",
                params = {{"EnableCommand", CMD.MANUALFIRE, true}},
                requiredUpgrades = 0
            }, {
                name = "E.M.P Overdrive",
                desc = "+50% Paralyze Time",
                params = {{"WeaponParalyzeTime", 2, 0.5}},
                requiredUpgrades = 1
            }, {
                name = "E.M.P Overclock",
                desc = "+50% Paralyze Time",
                params = {{"WeaponParalyzeTime", 2, 0.5}},
                requiredUpgrades = 4
            }, {
                name = "E.M.P Storm",
                desc = "+50% Paralyze Time",
                params = {{"WeaponParalyzeTime", 2, 0.5}},
                requiredUpgrades = 6
            }
        }
    },
    heropuppy = {
        onReady = {{"Scale", 0}},
        onLevelUp = {{"HP", 0.15}, {"Scale", 0.10}},
        path1 = {
            {
                name = "Missile Pods",
                desc = "+25% Damage",
                params = {{"WeaponDamage", 1, 0.25}},
                requiredUpgrades = 0
            }, {
                name = "HESH Ammo",
                desc = "+100% AOE",
                params = {{"WeaponAOE", 1, 1.0}},
                requiredUpgrades = 1
            }, {
                name = "Impact Upgrade",
                desc = "+25% Damage",
                params = {{"WeaponDamage", 1, 0.25}},
                requiredUpgrades = 4
            }, {
                name = "Cluster Grenade",
                desc = "+100% AOE",
                params = {{"WeaponAOE", 1, 1.0}},
                requiredUpgrades = 6
            }
        },
        path2 = {
            {
                name = "Extended Mag",
                desc = "+40% fire rate",
                params = {{"WeaponReload", 1, 0.4}},
                requiredUpgrades = 0
            }, {
                name = "Autoloader",
                desc = "+40% fire rate",
                params = {{"WeaponReload", 1, 0.4}},
                requiredUpgrades = 1
            }, {
                name = "Double Salvo",
                desc = "Two Salvos",
                params = {{"WeaponBurst", 1, 1}, {"WeaponReload", 1, -0.4}},
                requiredUpgrades = 4
            }, {
                name = "Overdrive",
                desc = "+40% fire rate",
                params = {{"WeaponReload", 1, 0.4}},
                requiredUpgrades = 6
            }
        },
        path3 = {
            {
                name = "Jump",
                desc = "Unlock Jump",
                params = {{"EnableCommand", CMD_JUMP, true}},
                requiredUpgrades = 0
            }, {
                name = "Light Armour",
                desc = "+1000 HP",
                params = {{"Armour", "1000"}},
                requiredUpgrades = 1
            }, {
                name = "Medium Armour",
                desc = "+1000 HP",
                params = {{"Armour", "1000"}},
                requiredUpgrades = 4
            }, {
                name = "Ultimate Armour",
                desc = "+1000 HP",
                params = {{"Armour", "1000"}},
                requiredUpgrades = 6
            }
        },
        path4 = {
            {
                name = "Puppy Gun",
                desc = "Unlock Puppy Gun",
                params = {{"EnableCommand", CMD.MANUALFIRE, true}},
                requiredUpgrades = 0
            }, {
                name = "Flock of Puppies",
                desc = "+2 Puppies",
                params = {{"WeaponBurst", 2, 2}},
                requiredUpgrades = 1
            }, {
                name = "Herd of Puppies",
                desc = "+2 Puppies",
                params = {{"WeaponBurst", 2, 2}},
                requiredUpgrades = 4
            }, {
                name = "Puppy Army",
                desc = "+4 Puppies",
                params = {{"WeaponBurst", 2, 4}},
                requiredUpgrades = 6
            }
        }
    },
    herosniper = {
        onReady = {{"Scale", -0.05}},
        onLevelUp = {{"HP", 0.25}, {"Scale", 0.05}},
        path1 = {
            {
                name = "Higher Calibre",
                desc = "+75% dmg",
                params = {{"WeaponDamage", 1, 0.75}},
                requiredUpgrades = 0
            }, {
                name = "Shrapnel",
                desc = "+120% AOE",
                params = {{"WeaponAOE", 1, 1.2}},
                requiredUpgrades = 1
            }, {
                name = "Improved Percing",
                desc = "+75% dmg",
                params = {{"WeaponDamage", 1, 0.75}},
                requiredUpgrades = 4
            }, {
                name = "Improved Piercing",
                desc = "+75% dmg",
                params = {{"WeaponDamage", 1, 0.75}},
                requiredUpgrades = 6
            }
        },
        path2 = {
            {
                name = "Extended Mag",
                desc = "+20% fire rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 0
            }, {
                name = "Improved Firerate",
                desc = "+20% fire rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 1
            }, {
                name = "Semi-Automatic",
                desc = "+20% fire rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 4
            }, {
                name = "Belt-Fed",
                desc = "+20% fire rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 6
            }
        },
        path3 = {
            {
                name = "Improved Servo",
                desc = "+25% move speed",
                params = {{"MoveSpeed", "0.25"}},
                requiredUpgrades = 0
            }, {
                name = "Advanced Motors",
                desc = "+25% move speed",
                params = {{"MoveSpeed", "0.25"}},
                requiredUpgrades = 1
            }, {
                name = "Industrial Motors",
                desc = "+25% move speed",
                params = {{"MoveSpeed", "0.25"}},
                requiredUpgrades = 4
            }, {
                name = "Experimental Servo",
                desc = "+25% move speed",
                params = {{"MoveSpeed", "0.25"}},
                requiredUpgrades = 6
            }
        },
        path4 = {
            {
                name = "Shock Rifle",
                desc = "Unlock Shock Rifle",
                params = {{"EnableCommand", CMD.MANUALFIRE, true}},
                requiredUpgrades = 0
            }, {
                name = "Higher Calibre",
                desc = "+35% dmg",
                params = {{"WeaponDamage", 2, 0.35}},
                requiredUpgrades = 1
            }, {
                name = "H.E.A.T Ammo",
                desc = "+35% dmg",
                params = {{"WeaponDamage", 2, 0.35}},
                requiredUpgrades = 4
            }, {
                name = "Max Calibre",
                desc = "+35% dmg",
                params = {{"WeaponDamage", 2, 0.35}},
                requiredUpgrades = 6
            }
        }
    },
    herodante = {
        onReady = {
            {"Scale", -0.15}, {"WeaponRange", 1, -1}, {"WeaponRange", 2, -1}
        },
        onLevelUp = {{"HP", 0.10}, {"Scale", 0.07}},
        path1 = {
            {
                name = "Fire Rockets",
                desc = "Unlock Fire Rockets",
                params = {{"WeaponRange", 1, 1}},
                requiredUpgrades = 0
            }, {
                name = "Advanced Explosives",
                desc = "+25% Rocket Damage",
                params = {{"WeaponDamage", 2, 0.25}},
                requiredUpgrades = 1
            }, {
                name = "Quadra Rockets",
                desc = "+2 Rockets",
                params = {{"WeaponBurst", 1, 2}},
                requiredUpgrades = 4
            }, {
                name = "Hell Fire",
                desc = "+25% Rocket Damage",
                params = {{"WeaponDamage", 1, 0.25}},
                requiredUpgrades = 6
            }
        },
        path2 = {
            {
                name = "Double Heatray",
                desc = "Unlock Heatray",
                params = {{"WeaponRange", 2, 1}},
                requiredUpgrades = 0
            }, {
                name = "Heat Core",
                desc = "+25% Damage",
                params = {{"WeaponDamage", 2, 0.25}},
                requiredUpgrades = 1
            }, {
                name = "Heat Pipelines",
                desc = "+20% Damage\n+20% Move Speed",
                params = {{"WeaponDamage", 2, 0.2}, {"MoveSpeed", 0.2}},
                requiredUpgrades = 4
            }, {
                name = "Sun Core",
                desc = "+20% Damage\n+20% Move Speed",
                params = {{"WeaponDamage", 2, 0.2}, {"MoveSpeed", 0.2}},
                requiredUpgrades = 6
            }
        },
        path3 = {
            {
                name = "Faster Repair",
                desc = "+30% Faster Regen Time",
                params = {{"IdleRegen", -0.30, 0}},
                requiredUpgrades = 0
            }, {
                name = "Medium Repair",
                desc = "+20% Regen Amount",
                params = {{"IdleRegen", 0, 0.2}},
                requiredUpgrades = 1
            }, {
                name = "Enhanced Repair",
                desc = "+30% Faster Regen Time\n+20% Regen Amount",
                params = {{"IdleRegen", -0.3, 0.2}},
                requiredUpgrades = 4
            }, {
                name = "Ultimate Repair",
                desc = "+30% Faster Regen Time\n+20% Regen Amount",
                params = {{"IdleRegen", -0.3, 0.2}},
                requiredUpgrades = 6
            }
        },
        path4 = {
            {
                name = "Rocket Salvo",
                desc = "Unlock Rocket Salvo",
                params = {{"EnableCommand", CMD.MANUALFIRE, true}},
                requiredUpgrades = 0
            }, {
                name = "Extra Rockets",
                desc = "+5 Rockets",
                params = {{"WeaponBurst", 3, 5}},
                requiredUpgrades = 1
            }, {
                name = "Rocket Swarm",
                desc = "+5 Rockets",
                params = {{"WeaponBurst", 3, 5}},
                requiredUpgrades = 4
            }, {
                name = "Rocket Armada",
                desc = "+5 Rockets",
                params = {{"WeaponBurst", 3, 5}},
                requiredUpgrades = 6
            }
        }
    }
}

return HeroDefs
