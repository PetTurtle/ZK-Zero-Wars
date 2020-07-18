VFS.Include("LuaRules/Configs/customcmds.h.lua")

local HeroDefs = {
    heroknight = {
        onReady = {{"Scale", -0.05}, {"EnableCommand", CMD.MANUALFIRE, false}},
        onLevelUp = {{"HP", 0.1}, {"Scale", 0.05}},
        path1 = {
            {
                name = "Plasma Upgrade",
                desc = "+25% Damage",
                params = {{"WeaponDamage", 1, 0.25}},
                requiredUpgrades = 0
            }, {
                name = "Ionized plasma",
                desc = "+25% Damage",
                params = {{"WeaponDamage", 1, 0.25}},
                requiredUpgrades = 1
            }, {
                name = "Tesla Upgrade",
                desc = "+25% Damage",
                params = {{"WeaponDamage", 1, 0.25}},
                requiredUpgrades = 4
            }, {
                name = "Sun Core",
                desc = "+25% Damage",
                params = {{"WeaponDamage", 1, 0.25}},
                requiredUpgrades = 6
            }
        },
        path2 = {
            {
                name = "Lazer Cooling",
                desc = "+15% Fire Rate",
                params = {{"WeaponReload", 1, 0.15}},
                requiredUpgrades = 0
            }, {
                name = "Heat Pipes",
                desc = "+15% Fire Rate",
                params = {{"WeaponReload", 1, 0.15}},
                requiredUpgrades = 1
            }, {
                name = "Nitrogen Tank",
                desc = "+15% Fire Rate",
                params = {{"WeaponReload", 1, 0.15}},
                requiredUpgrades = 4
            }, {
                name = "Sub Zero",
                desc = "+15% Fire Rate",
                params = {{"WeaponReload", 1, 0.15}},
                requiredUpgrades = 6
            }
        },
        path3 = {
            {
                name = "Light Armour",
                desc = "+1500 HP",
                params = {{"Armour", "1500"}},
                requiredUpgrades = 0
            }, {
                name = "Medium Armour",
                desc = "+1500 HP",
                params = {{"Armour", "1500"}},
                requiredUpgrades = 1
            }, {
                name = "Heavy Armour",
                desc = "+1500 HP",
                params = {{"Armour", "1500"}},
                requiredUpgrades = 4
            }, {
                name = "Ultimate Armour",
                desc = "+1500 HP",
                params = {{"Armour", "1500"}},
                requiredUpgrades = 6
            }
        },
        path4 = {
            {
                name = "Gauss Blast",
                desc = "Unlock Gauss Blast",
                params = {{"EnableCommand", CMD.MANUALFIRE, true}},
                requiredUpgrades = 6
            }, {
                name = "Extra Gauss",
                desc = "+1 Burst",
                params = {{"WeaponBurst", 2, 1}},
                requiredUpgrades = 8
            }, {
                name = "Gauss Array",
                desc = "+1 Burst",
                params = {{"WeaponBurst", 2, 1}},
                requiredUpgrades = 10
            }, {
                name = "Recursive Gauss",
                desc = "+2 Burst",
                params = {{"WeaponBurst", 2, 2}},
                requiredUpgrades = 12
            }
        }
    },
    heroduck = {
        onReady = {{"Scale", -0.05}, {"EnableCommand", CMD.MANUALFIRE, false}},
        onLevelUp = {{"HP", 0.15}, {"Scale", 0.05}},
        path1 = {
            {
                name = "Heavy Grenade",
                desc = "+50% Damage",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 0
            }, {
                name = "HESH Ammo",
                desc = "+25% AOE",
                params = {{"WeaponAOE", 1, 0.25}},
                requiredUpgrades = 1
            }, {
                name = "Impact Upgrade",
                desc = "+50% Damage",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 4
            }, {
                name = "Cluster Grenade",
                desc = "+25% AOE",
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
                desc = "Two Salvos\n-50% Fire Rate",
                params = {{"WeaponBurst", 1, 1}, {"WeaponReload", 1, -0.5}},
                requiredUpgrades = 4
            }, {
                name = "Liquid Cooling",
                desc = "+25% Fire Rate",
                params = {{"WeaponReload", 1, 0.25}},
                requiredUpgrades = 6
            }
        },
        path3 = {
            {
                name = "Light Armour",
                desc = "+800 HP",
                params = {{"Armour", "800"}},
                requiredUpgrades = 0
            }, {
                name = "Medium Armour",
                desc = "+800 HP",
                params = {{"Armour", "800"}},
                requiredUpgrades = 1
            }, {
                name = "Heavy Armour",
                desc = "+800 HP",
                params = {{"Armour", "800"}},
                requiredUpgrades = 4
            }, {
                name = "Ultimate Armour",
                desc = "+800 HP",
                params = {{"Armour", "800"}},
                requiredUpgrades = 6
            }
        },
        path4 = {
            {
                name = "E.M.P Blast",
                desc = "Unlock E.M.P Blast",
                params = {{"EnableCommand", CMD.MANUALFIRE, true}},
                requiredUpgrades = 6
            }, {
                name = "E.M.P Overdrive",
                desc = "+75% Paralyze Time",
                params = {{"WeaponParalyzeTime", 2, 0.75}},
                requiredUpgrades = 8
            }, {
                name = "E.M.P Overclock",
                desc = "+75% Paralyze Time",
                params = {{"WeaponParalyzeTime", 2, 0.75}},
                requiredUpgrades = 10
            }, {
                name = "E.M.P Storm",
                desc = "+75% Paralyze Time",
                params = {{"WeaponParalyzeTime", 2, 0.75}},
                requiredUpgrades = 12
            }
        }
    },
    heropuppy = {
        onReady = {
            {"Scale", 0}, {"EnableCommand", CMD.MANUALFIRE, false},
            {"EnableCommand", CMD_JUMP, false}

        },
        onLevelUp = {{"HP", 0.15}, {"Scale", 0.10}},
        path1 = {
            {
                name = "Missile Pods",
                desc = "+40% Damage",
                params = {{"WeaponDamage", 1, 0.40}},
                requiredUpgrades = 0
            }, {
                name = "HESH Ammo",
                desc = "+50% AOE",
                params = {{"WeaponAOE", 1, 0.5}},
                requiredUpgrades = 1
            }, {
                name = "Impact Upgrade",
                desc = "+40% Damage",
                params = {{"WeaponDamage", 1, 0.40}},
                requiredUpgrades = 4
            }, {
                name = "Cluster Grenade",
                desc = "+50% AOE",
                params = {{"WeaponAOE", 1, 0.5}},
                requiredUpgrades = 6
            }
        },
        path2 = {
            {
                name = "Extended Mag",
                desc = "+40% Fire Rate",
                params = {{"WeaponReload", 1, 0.4}},
                requiredUpgrades = 0
            }, {
                name = "Autoloader",
                desc = "+40% Fire Rate",
                params = {{"WeaponReload", 1, 0.4}},
                requiredUpgrades = 1
            }, {
                name = "Double Salvo",
                desc = "Two Salvos\n-40% Fire Rate",
                params = {{"WeaponBurst", 1, 1}, {"WeaponReload", 1, -0.4}},
                requiredUpgrades = 4
            }, {
                name = "Overdrive",
                desc = "+40% Fire Rate",
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
                params = {{"Armour", "1000"}, {"Scale", 0.05}},
                requiredUpgrades = 1
            }, {
                name = "Medium Armour",
                desc = "+1000 HP",
                params = {{"Armour", "1000"}, {"Scale", 0.05}},
                requiredUpgrades = 4
            }, {
                name = "Ultimate Armour",
                desc = "+1000 HP",
                params = {{"Armour", "1000"}, {"Scale", 0.05}},
                requiredUpgrades = 6
            }
        },
        path4 = {
            {
                name = "Puppy Gun",
                desc = "Unlock Puppy Gun",
                params = {{"EnableCommand", CMD.MANUALFIRE, true}},
                requiredUpgrades = 6
            }, {
                name = "Flock of Puppies",
                desc = "+2 Puppies",
                params = {{"WeaponBurst", 2, 2}},
                requiredUpgrades = 8
            }, {
                name = "Herd of Puppies",
                desc = "+2 Puppies",
                params = {{"WeaponBurst", 2, 2}},
                requiredUpgrades = 10
            }, {
                name = "Puppy Army",
                desc = "+4 Puppies",
                params = {{"WeaponBurst", 2, 4}},
                requiredUpgrades = 12
            }
        }
    },
    herosniper = {
        onReady = {{"Scale", -0.05}, {"EnableCommand", CMD.MANUALFIRE, false}},
        onLevelUp = {{"HP", 0.25}, {"Scale", 0.05}},
        path1 = {
            {
                name = "Higher Calibre",
                desc = "+50% Damage",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 0
            }, {
                name = "Shrapnel",
                desc = "+60% AOE",
                params = {{"WeaponAOE", 1, 0.6}},
                requiredUpgrades = 1
            }, {
                name = "Improved Percing",
                desc = "+50% Damage",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 4
            }, {
                name = "Improved Piercing",
                desc = "+50% Damage",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 6
            }
        },
        path2 = {
            {
                name = "Extended Mag",
                desc = "+20% Fire Rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 0
            }, {
                name = "Improved Firerate",
                desc = "+20% Fire Rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 1
            }, {
                name = "Semi-Automatic",
                desc = "+20% Fire Rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 4
            }, {
                name = "Belt-Fed",
                desc = "+20% Fire Rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 6
            }
        },
        path3 = {
            {
                name = "Improved Servo",
                desc = "+20% Movement Speed",
                params = {{"MoveSpeed", "0.20"}},
                requiredUpgrades = 0
            }, {
                name = "Advanced Motors",
                desc = "+20% Movement Speed",
                params = {{"MoveSpeed", "0.20"}},
                requiredUpgrades = 1
            }, {
                name = "Industrial Motors",
                desc = "+20% Movement Speed",
                params = {{"MoveSpeed", "0.20"}},
                requiredUpgrades = 4
            }, {
                name = "Experimental Servo",
                desc = "+20% Movement Speed",
                params = {{"MoveSpeed", "0.20"}},
                requiredUpgrades = 6
            }
        },
        path4 = {
            {
                name = "Shock Rifle",
                desc = "Unlock Shock Rifle",
                params = {{"EnableCommand", CMD.MANUALFIRE, true}},
                requiredUpgrades = 6
            }, {
                name = "Higher Calibre",
                desc = "+35% Damage",
                params = {{"WeaponDamage", 2, 0.35}},
                requiredUpgrades = 8
            }, {
                name = "H.E.A.T Ammo",
                desc = "+35% Damage",
                params = {{"WeaponDamage", 2, 0.35}},
                requiredUpgrades = 10
            }, {
                name = "Max Calibre",
                desc = "+35% Damage",
                params = {{"WeaponDamage", 2, 0.35}},
                requiredUpgrades = 12
            }
        }
    },
    herodante = {
        onReady = {
            {"Scale", -0.15}, {"WeaponRange", 1, -1}, {"WeaponRange", 2, -1},
            {"EnableCommand", CMD.MANUALFIRE, false}
        },
        onLevelUp = {{"HP", 0.09}, {"Scale", 0.04}},
        path1 = {
            {
                name = "Fire Rockets",
                desc = "Unlock Fire Rockets",
                params = {{"WeaponRange", 1, 1}},
                requiredUpgrades = 0
            }, {
                name = "Advanced Explosives",
                desc = "+20% Rocket Damage",
                params = {{"WeaponDamage", 2, 0.20}},
                requiredUpgrades = 1
            }, {
                name = "Quadra Rockets",
                desc = "+2 Rockets",
                params = {{"WeaponBurst", 1, 2}},
                requiredUpgrades = 4
            }, {
                name = "Hell Fire",
                desc = "+20% Rocket Damage",
                params = {{"WeaponDamage", 1, 0.20}},
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
                desc = "+15% Damage",
                params = {{"WeaponDamage", 2, 0.15}},
                requiredUpgrades = 1
            }, {
                name = "Heat Pipelines",
                desc = "+15% Damage\n+20% Movement Speed",
                params = {{"WeaponDamage", 2, 0.2}, {"MoveSpeed", 0.15}},
                requiredUpgrades = 4
            }, {
                name = "Sun Core",
                desc = "+15% Damage\n+20% Movement Speed",
                params = {{"WeaponDamage", 2, 0.2}, {"MoveSpeed", 0.15}},
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
                requiredUpgrades = 6
            }, {
                name = "Extra Rockets",
                desc = "+5 Rockets",
                params = {{"WeaponBurst", 3, 5}},
                requiredUpgrades = 8
            }, {
                name = "Rocket Swarm",
                desc = "+5 Rockets",
                params = {{"WeaponBurst", 3, 5}},
                requiredUpgrades = 10
            }, {
                name = "Rocket Armada",
                desc = "+5 Rockets",
                params = {{"WeaponBurst", 3, 5}},
                requiredUpgrades = 12
            }
        }
    },
    heromoderator = {
        onReady = {
            {"Scale", -0.15}, {"EnableCommand", CMD.MANUALFIRE, false}
        },
        onLevelUp = {{"HP", 0.15}, {"Scale", 0.08}},
        path1 = {
            {
                name = "Adv Beamlaser",
                desc = "+50% Damage\n+50% Slow Damage",
                params = {{"WeaponDamage", 1, 0.5}},
                requiredUpgrades = 0
            }, {
                name = "Energy Crystal",
                desc = "+50% Damage\n+50% Slow Damage",
                params = {{"WeaponDamage", 2, 0.20}},
                requiredUpgrades = 1
            }, {
                name = "Beam Bundling",
                desc = "+50% Damage\n+50% Slow Damage",
                params = {{"WeaponDamage", 2, 0.20}},
                requiredUpgrades = 4
            }, {
                name = "Power Crystal",
                desc = "+50% Damage\n+50% Slow Damage",
                params = {{"WeaponDamage", 2, 0.20}},
                requiredUpgrades = 6
            }
        },
        path2 = {
            {
                name = "Cooling System",
                desc = "+20% Fire Rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 0
            }, {
                name = "Adv Circuits",
                desc = "+20% Fire Rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 1
            }, {
                name = "Cryo Stabylizer",
                desc = "+20% Fire Rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 4
            }, {
                name = "Resonant Conduit",
                desc = "+20% Fire Rate",
                params = {{"WeaponReload", 1, 0.2}},
                requiredUpgrades = 6
            }
        },
        path3 = {
            {
                name = "Light Armour",
                desc = "+800 HP",
                params = {{"Armour", "800"}},
                requiredUpgrades = 0
            }, {
                name = "Medium Armour",
                desc = "+800 HP",
                params = {{"Armour", "800"}},
                requiredUpgrades = 1
            }, {
                name = "Adv Targeting",
                desc = "+15% range",
                params = {{"WeaponRange", 1, 0.15}},
                requiredUpgrades = 4
            }, {
                name = "Precision Module",
                desc = "+15%  range",
                params = {{"WeaponRange", 1, 0.15}},
                requiredUpgrades = 6
            }
        },
        path4 = {
            {
                name = "Disruptor Bomb",
                desc = "Unlock Disruptor Bomb",
                params = {{"EnableCommand", CMD.MANUALFIRE, true}},
                requiredUpgrades = 6
            }, {
                name = "Time Distortion",
                desc = "+50% Damage",
                params = {{"WeaponDamage", 2, 0.5}},
                requiredUpgrades = 8
            }, {
                name = "Chronomancy",
                desc = "+50% Damage",
                params = {{"WeaponDamage", 2, 0.5}},
                requiredUpgrades = 10
            }, {
                name = "Violet Slugger",
                desc = "+50% Damage",
                params = {{"WeaponDamage", 2, 0.5}},
                requiredUpgrades = 12
            }
        }
    }
}

return HeroDefs
