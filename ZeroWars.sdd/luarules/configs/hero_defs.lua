Spring.GetModOptions = Spring.GetModOptions or function() return {} end

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
    for i = 1, 6 do spSetUnitWeaponDamages(unitID, weaponID, i, damage) end
end

local function enableCmd(unitID, CMD)
    local index = spFindUnitCmdDesc(unitID, CMD)
    if index then
        local cmdTable = spGetUnitCmdDescs(unitID, index)
        cmdTable.disabled = false
        spEditUnitCmdDesc(unitID, index, cmdTable)
    end
end

local HeroDefs = {
    heroknight = {
        stats = {minHP = 3000, maxHP = 10000, minScale = 1, maxScale = 2},
        path1 = {
            -- weapon dmg params
            [1] = {
                name = "Plasma Upgrade",
                desc = "+50 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 100)
                end
            },
            [2] = {
                name = "Ionized plasma",
                desc = "+50 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 150)
                end
            },
            [3] = {
                name = "Tesla Upgrade",
                desc = "+50 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 200)
                end
            },
            [4] = {
                name = "Sun Core",
                desc = "+50 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 250)
                end
            }
        },
        path2 = {
            -- weapon fire params
            [1] = {
                name = "Lazer Cooling",
                desc = "+10% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.10, weaponNum = 1})
                end
            },
            [2] = {
                name = "Heat Pipes",
                desc = "+33% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.33, weaponNum = 1})
                end
            },
            [3] = {
                name = "Nitrogen Tank",
                desc = "+50% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.5, weaponNum = 1})
                end
            },
            [4] = {
                name = "Sub Zero",
                desc = "+75% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.75, weaponNum = 1})
                end
            }
        },
        path3 = {
            -- armour
            [1] = {
                name = "Light Armour",
                desc = "+2000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 2000)
                end
            },
            [2] = {
                name = "Medium Armour",
                desc = "+2000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 4000)
                end
            },
            [3] = {
                name = "Heavy Armour",
                desc = "+2000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 6000)
                end
            },
            [4] = {
                name = "Ultimate Armour",
                desc = "+2000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 8000)
                end
            }
        },
        path4 = {
            -- dgun
            [1] = {
                name = "Gauss Blast",
                desc = "Pierces units in a line",
                upgrade = function(unitID, unitDefID, unitTeam)
                    enableCmd(unitID, CMD.MANUALFIRE)
                end
            },
            [2] = {
                name = "Extra Gauss",
                desc = "2 bursts",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 2, "burst", 2)
                end
            },
            [3] = {
                name = "Gauss Array",
                desc = "3 bursts",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 2, "burst", 3)
                end
            },
            [4] = {
                name = "Recursive Gauss",
                desc = "5 bursts",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 2, "burst", 5)
                end
            }
        }
    },
    heroduck = {
        stats = {minHP = 2000, maxHP = 9000, minScale = 1, maxScale = 2},
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
                desc = "+30% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.3, weaponNum = 1})
                end
            },
            [2] = {
                name = "Autoloader",
                desc = "+50% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.5, weaponNum = 1})
                end
            },
            [3] = {
                name = "Double Salvo",
                desc = "Two Salvos",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "burst", 2)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.0, weaponNum = 1})
                end
            },
            [4] = {
                name = "Liquid Cooling",
                desc = "+30% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.3, weaponNum = 1})
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
                desc = "Stuns all units in radius",
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
        stats = {minHP = 1400, maxHP = 7500, minScale = 1.5, maxScale = 3},
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
                desc = "+50% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.5, weaponNum = 1})
                end
            },
            [2] = {
                name = "Autoloader",
                desc = "+80% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.8, weaponNum = 1})
                end
            },
            [3] = {
                name = "Double Salvo",
                desc = "Two Salvos",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "burst", 2)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.0, weaponNum = 1})
                end
            },
            [4] = {
                name = "Overdrive",
                desc = "+30% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.3, weaponNum = 1})
                end
            }
        },
        path3 = {
            -- armour
            [1] = {
                name = "Jump",
                desc = "unlock jump",
                upgrade = function(unitID, unitDefID, unitTeam)
                    enableCmd(unitID, CMD_JUMP)
                end
            },
            [2] = {
                name = "Light Armour",
                desc = "+1000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 2000)
                end
            },
            [3] = {
                name = "Medium Armour",
                desc = "+1000 HP",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitRulesParam(unitID, "armour", 1000)
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
        stats = {minHP = 1400, maxHP = 7000, minScale = 1, maxScale = 2},
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
                desc = "+20% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.2, weaponNum = 1})
                end
            },
            [2] = {
                name = "Improved Firerate",
                desc = "+40% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.4, weaponNum = 1})
                end
            },
            [3] = {
                name = "Semi-Automatic",
                desc = "+60% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.6, weaponNum = 1})
                end
            },
            [4] = {
                name = "Belt-Fed",
                desc = "+80% fire rate",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.Attributes.AddEffect(unitID, "weapon1",
                                            {reload = 1.8, weaponNum = 1})
                end
            }
        },
        path3 = {
            -- speed
            [1] = {
                name = "Improved Servo",
                desc = "1.25x move speed",
                upgrade = function(unitID, unitDefID, unitTeam)
                    Spring.SetUnitRulesParam(unitID, "upgradesSpeedMult", 1.25)
                    GG.UpdateUnitAttributes(unitID)
                end
            },
            [2] = {
                name = "Advanced Motors",
                desc = "1.5x move speed",
                upgrade = function(unitID, unitDefID, unitTeam)
                    Spring.SetUnitRulesParam(unitID, "upgradesSpeedMult", 1.5)
                    GG.UpdateUnitAttributes(unitID)
                end
            },
            [3] = {
                name = "Industrial Motors",
                desc = "1.75x move speed",
                upgrade = function(unitID, unitDefID, unitTeam)
                    Spring.SetUnitRulesParam(unitID, "upgradesSpeedMult", 1.75)
                    GG.UpdateUnitAttributes(unitID)
                end
            },
            [4] = {
                name = "Experimental Servo",
                desc = "2x move speed",
                upgrade = function(unitID, unitDefID, unitTeam)
                    Spring.SetUnitRulesParam(unitID, "upgradesSpeedMult", 2)
                    GG.UpdateUnitAttributes(unitID)
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
                desc = "+ 1500 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 2, 5500)
                end
            },
            [3] = {
                name = "H.E.A.T Ammo",
                desc = "+ 1500 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 2, 7000)
                end
            },
            [4] = {
                name = "Max Calibre",
                desc = "+ 1500 dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 2, 8500)
                end
            }
        }
    },
    herodante = {
        stats = {minHP = 3500, maxHP = 12000, minScale = 0.6, maxScale = 1.3},
        path1 = {
            -- rocket weapon params
            [1] = {
                name = "Fire Rockets",
                desc = "enable 2x fire rocket weapons",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "range", 460)
                end
            },
            [2] = {
                name = "Advanced Explosives",
                desc = "+120 dmg each",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 240)
                end
            },
            [3] = {
                name = "Quadra Rockets",
                desc = "4 rockets",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 1, "burst", 4)
                end
            },
            [4] = {
                name = "Hell Fire",
                desc = "+240 dmg each",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 1, 480)
                end
            }
        },
        path2 = {
            -- heatray weapon params
            [1] = {
                name = "Double Heatray",
                desc = "enable 2x heatray weapons",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 2, "range", 430)
                end
            },
            [2] = {
                name = "Heat Core",
                desc = "+50% dmg",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 2, 75)
                end
            },
            [3] = {
                name = "Heat Pipelines",
                desc = "+20% dmg, 1.3x move speed",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 2, 85)
                    Spring.SetUnitRulesParam(unitID, "upgradesSpeedMult", 1.3)
                    GG.UpdateUnitAttributes(unitID)
                end
            },
            [4] = {
                name = "Sun Core",
                desc = "+30% dmg, 1.6x move speed",
                upgrade = function(unitID, unitDefID, unitTeam)
                    setWeaponDamage(unitID, 2, 100)
                    Spring.SetUnitRulesParam(unitID, "upgradesSpeedMult", 1.6)
                    GG.UpdateUnitAttributes(unitID)
                end
            }
        },
        path3 = {
            -- Autoregen 
            -- GG.SetUnitIdleRegen(unitID, 600, 250)
            -- (unitID, regenidletime = number / 30, regenamount)
            -- regenamount displayed on healthbar does currently not update its value
            [1] = {
                name = "Faster Repair",
                desc = "reduce regentime to 5 sec",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.SetUnitIdleRegen(unitID, 150, 250)
                end
            },
            [2] = {
                name = "Medium Repair",
                desc = "+50 hp/s reduce regentime to 4 sec",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.SetUnitIdleRegen(unitID, 120, 300)
                end
            },
            [3] = {
                name = "Enhanced Repair",
                desc = "+100 hp/s reduce regentime to 3.5 sec",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.SetUnitIdleRegen(unitID, 105, 400)
                end
            },
            [4] = {
                name = "Ultimate Repair",
                desc = "+100 hp/s reduce regentime to 3 sec",
                upgrade = function(unitID, unitDefID, unitTeam)
                    GG.SetUnitIdleRegen(unitID, 90, 500)
                end
            }
        },
        path4 = {
            -- dgun
            [1] = {
                name = "Rocket Salvo",
                desc = "Fires 30 upgraded rockets, disables rocket attack while reloading",
                upgrade = function(unitID, unitDefID, unitTeam)
                    enableCmd(unitID, CMD.MANUALFIRE)
                end
            },
            [2] = {
                name = "Extra Rockets",
                desc = "Fires 50 upgraded rockets, disables rocket attack while reloading",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 3, "burst", 25)
                end
            },
            [3] = {
                name = "Rocket Swarm",
                desc = "Fires 70 upgraded rockets, disables rocket attack while reloading",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 3, "burst", 35)
                end
            },
            [4] = {
                name = "Rocket Armada",
                desc = "Fires 100 upgraded rockets, disables rocket attack while reloading",
                upgrade = function(unitID, unitDefID, unitTeam)
                    spSetUnitWeaponState(unitID, 3, "burst", 50)
                end
            }
        }
    }
}

return HeroDefs
