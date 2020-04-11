Spring.GetModOptions = Spring.GetModOptions or function()
        return {}
    end

-- SyncedCtrl
local spSetUnitRulesParam = Spring.SetUnitRulesParam
local spSetUnitWeaponState = Spring.SetUnitWeaponState
local spSetUnitWeaponDamages = Spring.SetUnitWeaponDamages
local spEditUnitCmdDesc = Spring.EditUnitCmdDesc

-- SyncedRead
local spFindUnitCmdDesc = Spring.FindUnitCmdDesc
local spGetUnitCmdDescs = Spring.GetUnitCmdDescs

include("LuaRules/Configs/customcmds.h.lua")

local function setWeaponDamage(unitID, weaponID, damage)
    for i = 1, 6 do
        spSetUnitWeaponDamages(unitID, weaponID, i, damage)
    end
end

local function enableCmd(unitID, CMD)
    local index = spFindUnitCmdDesc(unitID, CMD)
    if index then
        local cmdTable = spGetUnitCmdDescs(unitID, index)
        cmdTable.disabled = false
        spEditUnitCmdDesc(unitID, index, cmdTable)
    end
end

local HeroUpgradeDefs = {
    heroknight = {
        stats = {
            minHP = 3000,
            maxHP = 10000,
            minScale = 1,
            maxScale = 2
        },
        path1 = {
            -- weapon dmg params
            [1] = {
                name = "HEAT Ray",
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
                    enableCmd(unitID, CMD.MANUALFIRE)
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
    heroduck = {
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
                desc = "+200 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 600)
                end
            },
            [2] = {
                name = "HESH Ammo",
                desc = "+30 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 150)
                end
            },
            [3] = {
                name = "Impact Upgrade",
                desc = "+200 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 800)
                end
            },
            [4] = {
                name = "Cluster Grenade",
                desc = "+50 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 200)
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
                desc = "+1000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 1000)
                end
            },
            [2] = {
                name = "Medium Armour",
                desc = "+1000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 2000)
                end
            },
            [3] = {
                name = "Heavy Armour",
                desc = "+1000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 3000)
                end
            },
            [4] = {
                name = "Ultimate Armour",
                desc = "+2000 HP",
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
                    enableCmd(unitID, CMD.MANUALFIRE)
                end
            },
            [2] = {
                name = "E.M.P Overdrive",
                desc = "Increase Stun to 4.5s",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 2, "paralyzeDamageTime", 4.5)
                end
            },
            [3] = {
                name = "E.M.P Overclock",
                desc = "Increase Stun to 6s",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 2, "paralyzeDamageTime", 6)
                end
            },
            [4] = {
                name = "E.M.P Storm",
                desc = "Increase Stun to 8s",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 2, "paralyzeDamageTime", 8)
                end
            }
        }
    },
    heropuppy = {
        stats = {
            minHP = 1400,
            maxHP = 7500,
            minScale = 1.5,
            maxScale = 3
        },
        path1 = {
            -- weapon dmg params
            [1] = {
                name = "Missile Pods",
                desc = "+100 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 500)
                end
            },
            [2] = {
                name = "HESH Ammo",
                desc = "+50 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 100)
                end
            },
            [3] = {
                name = "Impact Upgrade",
                desc = "+100 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 600)
                end
            },
            [4] = {
                name = "Cluster Grenade",
                desc = "+50 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 150)
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
                    spSetUnitWeaponState(unitID, 1, "reloadTime", 1.2)
                    spSetUnitWeaponState(unitID, 1, "burst", 2)
                end
            },
            [4] = {
                name = "Overdrive",
                desc = "less time between salvoes",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "reloadTime", 0.8)
                end
            }
        },
        path3 = {
            -- armour
            [1] = {
                name = "Light Armour",
                desc = "+1000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 1000)
                end
            },
            [2] = {
                name = "Medium Armour",
                desc = "+1000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 2000)
                end
            },
            [3] = {
                name = "Jump",
                desc = "unlock jump",
                upgrade = function(unitID, unitDefID, unitTeam)
                    enableCmd(unitID, CMD_JUMP)
                end
            },
            [4] = {
                name = "Ultimate Armour",
                desc = "+1000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 3000)
                end
            }
        },
        path4 = {
            -- dgun
            [1] = {
                name = "Puppy Spawner",
                desc = "spawns 4 puppies",
                upgrade = function(unitID, unitDefID, unitTeam)
                    enableCmd(unitID, CMD.MANUALFIRE)
                end
            },
            [2] = {
                name = "Flock of Puppies",
                desc = "spawns 6 puppies",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 2, "burst", 6)
                end
            },
            [3] = {
                name = "Herd of Puppies",
                desc = "spawns 8 puppies",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 2, "burst", 8)
                end
            },
            [4] = {
                name = "Puppy Army",
                desc = "spawns 12 puppies",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 2, "burst", 12)
                end
            }
        }
    },
    herosniper = {
        stats = {
            minHP = 1400,
            maxHP = 7000,
            minScale = 1,
            maxScale = 2
        },
        path1 = {
            -- weapon dmg params
            [1] = {
                name = "Higher Calibre",
                desc = "+100 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 400)
                end
            },
            [2] = {
                name = "Shrapnel",
                desc = "+60 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 110)
                end
            },
            [3] = {
                name = "Improved Percing",
                desc = "+100 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 500)
                end
            },
            [4] = {
                name = "Improved Piercing",
                desc = "+100 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 600)
                end
            }
        },
        path2 = {
            -- weapon fire params
            [1] = {
                name = "Extended Mag",
                desc = "1.75s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "reloadTime", 1.75)
                end
            },
            [2] = {
                name = "Improved Firerate",
                desc = "1.5s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "reloadTime", 1.5)
                end
            },
            [3] = {
                name = "Semi-Automatic",
                desc = "1.25s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "reloadTime", 1.25)
                end
            },
            [4] = {
                name = "Belt-Fed",
                desc = " 1s between shots",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "reloadTime", 1)
                end
            }
        },
        path3 = {
            -- speed
            [1] = {
                name = "Improved Servo",
                desc = "+ Unit Max Speed",
                upgrade = function(unitID, unitDefID, unitTeam)
                    Spring.MoveCtrl.SetGroundMoveTypeData(unitID, "maxSpeed", 60)
                end
            },
            [2] = {
                name = "Advanced Motors",
                desc = "+ Unit Max Speed",
                upgrade = function(unitID, unitDefID, unitTeam)
                    Spring.MoveCtrl.SetGroundMoveTypeData(unitID, "maxSpeed", 75)
                end
            },
            [3] = {
                name = "Industrial Motors",
                desc = "+ Unit Max Speed",
                upgrade = function(unitID, unitDefID, unitTeam)
                    Spring.MoveCtrl.SetGroundMoveTypeData(unitID, "maxSpeed", 90)
                end
            },
            [4] = {
                name = "Experimental Servo",
                desc = "+ Unit Max Speed",
                upgrade = function(unitID, unitDefID, unitTeam)
                    Spring.MoveCtrl.SetGroundMoveTypeData(unitID, "maxSpeed", 105)
                end
            }
        },
        path4 = {
            -- dgun
            [1] = {
                name = "Shock Rifle",
                desc = "Pulsed Particle Projector",
                upgrade = function(unitID, unitDefID, unitTeam)
                    enableCmd(unitID, CMD.MANUALFIRE)
                end
            },
            [2] = {
                name = "Higher Calibre",
                desc = "+ 1000 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 2, 3500)
                end
            },
            [3] = {
                name = "H.E.A.T Ammo",
                desc = "+150 aoe",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponDamages(unitID, 2, "damageAreaOfEffect", 180)
                end
            },
            [4] = {
                name = "Max Calibre",
                desc = "+ 1000 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 2, 4500)
                end
            }
        }
    }
}

return HeroUpgradeDefs
