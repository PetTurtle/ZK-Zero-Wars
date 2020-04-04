Spring.GetModOptions = Spring.GetModOptions or function()
        return {}
    end

-- SyncedCtrl
local spSetUnitRulesParam = Spring.SetUnitRulesParam
local spSetUnitWeaponState = Spring.SetUnitWeaponState
local spSetUnitWeaponDamages = Spring.SetUnitWeaponDamages

local function setWeaponDamage(unitID, weaponID, damage)
    for i = 1, 6 do
        spSetUnitWeaponDamages(unitID, weaponID, i, damage)
    end
end

local HeroUpgradeDefs = {
    heroknight = {
        stats = {
            minHP = 2000,
            maxHP = 9000,
            minScale = 1,
            maxScale = 2
        },
        path1 = {
            -- weapon dmg params
            [1] = {
                name = "Heavy Grenade",
                desc = "+20 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "HESH Ammo",
                desc = "+30 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "Impact Upgrade",
                desc = "+20 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "Cluster Grenade",
                desc = "+30 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        },
        path2 = {
            -- weapon fire params
            [1] = {
                name = "Extended Mag",
                desc = "1.0s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "Autoloader",
                desc = "0.8s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "Double Salvo",
                desc = "Two Salvos",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "Lazer Accuracy",
                desc = " Grenades never miss",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        },
        path3 = {
            -- armour
            [1] = {
                name = "Light Armour",
                desc = "1000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "Medium Armour",
                desc = "2000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "Heavy Armour",
                desc = "3000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "Ultimate Armour",
                desc = "5000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        },
        path4 = {
            -- dgun
            [1] = {
                name = "E.M.P Blast",
                desc = "Stuns All Units in radius",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "E.M.P Overdrive",
                desc = "Increase Stun for 4s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "E.M.P Overclock",
                desc = "Increase Stun for 5s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "E.M.P Storm",
                desc = "Increase Stun By 6s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        }
    },
    heroreaver = {
        stats = {
            minHP = 2000,
            maxHP = 9000,
            minScale = 1,
            maxScale = 2
        },
        path1 = {
            -- weapon dmg params
            [1] = {
                name = "Heavy Grenade",
                desc = "+20 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 140)
                end
            },
            [2] = {
                name = "HESH Ammo",
                desc = "+30 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 280)
                end
            },
            [3] = {
                name = "Impact Upgrade",
                desc = "+20 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 160)
                end
            },
            [4] = {
                name = "Cluster Grenade",
                desc = "+30 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 310)
                end
            }
        },
        path2 = {
            -- weapon fire params
            [1] = {
                name = "Extended Mag",
                desc = "1.0s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "reloadTime", 1)
                end
            },
            [2] = {
                name = "Autoloader",
                desc = "0.8s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "reloadTime", 0.8)
                end
            },
            [3] = {
                name = "Double Salvo",
                desc = "Two Salvos",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "reloadTime", 1.3)
                    spSetUnitWeaponState(unitID, 1, "burst", 2)
                end
            },
            [4] = {
                name = "Liquid Cooling",
                desc = "Less time between salvos",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "reloadTime", 1.0)
                end
            }
        },
        path3 = {
            -- armour
            [1] = {
                name = "Light Armour",
                desc = "1000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 1000)
                end
            },
            [2] = {
                name = "Medium Armour",
                desc = "2000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 2000)
                end
            },
            [3] = {
                name = "Heavy Armour",
                desc = "3000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 3000)
                end
            },
            [4] = {
                name = "Ultimate Armour",
                desc = "5000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 5000)
                end
            }
        },
        path4 = {
            -- dgun
            [1] = {
                name = "E.M.P Blast",
                desc = "Stuns All Units in radius",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "E.M.P Overdrive",
                desc = "Increase Stun for 4s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "E.M.P Overclock",
                desc = "Increase Stun for 5s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "E.M.P Storm",
                desc = "Increase Stun By 6s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        }
    },
    heropuppy = {
        stats = {
            minHP = 2000,
            maxHP = 9000,
            minScale = 1,
            maxScale = 2
        },
        path1 = {
            -- weapon dmg params
            [1] = {
                name = "Heavy Grenade",
                desc = "+20 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "HESH Ammo",
                desc = "+30 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "Impact Upgrade",
                desc = "+20 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "Cluster Grenade",
                desc = "+30 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        },
        path2 = {
            -- weapon fire params
            [1] = {
                name = "Extended Mag",
                desc = "1.0s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "Autoloader",
                desc = "0.8s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "Double Salvo",
                desc = "Two Salvos",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "Lazer Accuracy",
                desc = " Grenades never miss",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        },
        path3 = {
            -- armour
            [1] = {
                name = "Light Armour",
                desc = "1000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "Medium Armour",
                desc = "2000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "Heavy Armour",
                desc = "3000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "Ultimate Armour",
                desc = "5000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        },
        path4 = {
            -- dgun
            [1] = {
                name = "E.M.P Blast",
                desc = "Stuns All Units in radius",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "E.M.P Overdrive",
                desc = "Increase Stun for 4s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "E.M.P Overclock",
                desc = "Increase Stun for 5s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "E.M.P Storm",
                desc = "Increase Stun By 6s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        }
    },
    herosniper = {
        stats = {
            minHP = 2000,
            maxHP = 9000,
            minScale = 1,
            maxScale = 2
        },
        path1 = {
            -- weapon dmg params
            [1] = {
                name = "Heavy Grenade",
                desc = "+20 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "HESH Ammo",
                desc = "+30 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "Impact Upgrade",
                desc = "+20 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "Cluster Grenade",
                desc = "+30 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        },
        path2 = {
            -- weapon fire params
            [1] = {
                name = "Extended Mag",
                desc = "1.0s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "Autoloader",
                desc = "0.8s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "Double Salvo",
                desc = "Two Salvos",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "Lazer Accuracy",
                desc = " Grenades never miss",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        },
        path3 = {
            -- armour
            [1] = {
                name = "Light Armour",
                desc = "1000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "Medium Armour",
                desc = "2000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "Heavy Armour",
                desc = "3000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "Ultimate Armour",
                desc = "5000 HP Increase",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        },
        path4 = {
            -- dgun
            [1] = {
                name = "E.M.P Blast",
                desc = "Stuns All Units in radius",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [2] = {
                name = "E.M.P Overdrive",
                desc = "Increase Stun for 4s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [3] = {
                name = "E.M.P Overclock",
                desc = "Increase Stun for 5s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            },
            [4] = {
                name = "E.M.P Storm",
                desc = "Increase Stun By 6s",
                upgrade = function(unitID, unitDefID, unitTeam)
                end
            }
        }
    }
}

return HeroUpgradeDefs
