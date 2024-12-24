local unit_tweaks = {
    chicken_drone_starter = {
        customparams = {
            statsname = nil,
            comDrone = true,
            morphto_1 = [[heroknight]],
            morphcost_1 = 1,
            morphtime_1 = 1,
            morphto_2 = [[heroduck]],
            morphcost_2 = 1,
            morphtime_2 = 1,
            morphto_3 = [[heropuppy]],
            morphcost_3 = 1,
            morphtime_3 = 1,
            morphto_4 = [[herosniper]],
            morphcost_4 = 1,
            morphtime_4 = 1,
            morphto_5 = [[herodante]],
            morphcost_5 = 1,
            morphtime_5 = 1,
            morphto_6 = [[heromoderator]],
            morphcost_6 = 1,
            morphtime_6 = 1
        }
    },
    factorycloak = {
        buildoptions = {
            [[builder]], [[cloakraid]], [[cloakheavyraid]], [[cloakskirm]],
            [[cloakriot]], [[cloakassault]], [[cloakarty]], [[cloaksnipe]],
            [[cloakaa]], [[cloakbomb]], [[striderantiheavy]]
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[cloakraid]],
            pos_weird_raider = [[cloakheavyraid]],
            pos_skirmisher = [[cloakskirm]],
            pos_riot = [[cloakriot]],
            pos_anti_air = [[cloakaa]],
            pos_assault = [[cloakassault]],
            pos_artillery = [[cloakarty]],
            pos_heavy_something = [[cloaksnipe]],
            pos_special = [[cloakbomb]],
            pos_utility = [[striderantiheavy]]
        },
        metalCost = 800,
        buildDistance = 800,
        script = [[cfactorycloak.lua]],
        yardMap = ""
    },
    factoryshield = {
        buildoptions = {[[builder]]},
        customParams = {pos_constructor = [[builder]]},
        metalCost = 800,
        buildDistance = 800,
        script = [[cfactoryshield.lua]],
        yardMap = ""
    },
    factoryveh = {
        buildoptions = {[[builder]]},
        customParams = {pos_constructor = [[builder]]},
        metalCost = 800,
        buildDistance = 800,
        script = [[cfactoryveh.lua]],
        yardMap = ""
    },
    factorytank = {
        buildoptions = {
            [[builder]], [[tankraid]], [[tankheavyraid]], [[tankriot]],
            [[tankarty]], [[striderarty]], [[tankaa]], [[tankassault]],
            [[tankheavyassault]]
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[tankraid]],
            pos_weird_raider = [[tankheavyraid]],
            pos_riot = [[tankriot]],
            pos_anti_air = [[tankaa]],
            pos_assault = [[tankassault]],
            pos_artillery = [[striderarty]],
            pos_heavy_something = [[tankheavyassault]],
            pos_utility = [[striderarty]]
        },
        metalCost = 800,
        buildDistance = 800,
        script = [[cfactorytank.lua]],
        yardMap = ""
    },
    factoryhover = {
        buildoptions = {
            [[builder]], [[hoverraid]], [[hoverheavyraid]],
            [[hoverdepthcharge]], [[hoverriot]], [[hoverskirm]], [[hoverarty]],
            [[hoveraa]], [[hoverassault]], [[hoverminer]], [[hovershotgun]]
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[hoverraid]],
            pos_weird_raider = [[hoverheavyraid]],
            pos_skirmisher = [[hoverskirm]],
            pos_riot = [[hoverriot]],
            pos_anti_air = [[hoveraa]],
            pos_assault = [[hoverassault]],
            pos_artillery = [[hoverarty]],
            pos_heavy_something = [[hovershotgun]],
            pos_special = [[hoverdepthcharge]],
            pos_utility = [[hoverminer]]
        },
        metalCost = 800,
        buildDistance = 800,
        script = [[cfactoryhover.lua]],
        yardMap = ""
    },
    factoryamph = {
        buildoptions = {
            [[builder]], [[amphraid]], [[amphimpulse]], [[amphfloater]],
            [[amphriot]], [[amphsupport]], [[amphassault]], [[cgrebe]], [[amphaa]], [[amphbomb]]
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[amphraid]],
            pos_weird_raider = [[amphimpulse]],
            pos_skirmisher = [[amphfloater]],
            pos_riot = [[amphriot]],
            pos_anti_air = [[amphaa]],
            pos_assault = [[cgrebe]],
            pos_heavy_something = [[amphassault]],
            pos_special = [[amphbomb]],
            pos_utility = [[amphsupport]],
        },
        metalCost = 800,
        buildDistance = 800,
        script = [[cfactoryamph.lua]],
        yardMap = ""
    },
    factoryjump = {
        buildoptions = {
            [[builder]], [[jumpscout]], [[jumpraid]], [[jumpskirm]],
            [[jumpblackhole]], [[jumpaa]], [[jumpassault]], [[jumpbomb]],
            [[jumpsumo]], [[striderdante]]
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[jumpraid]],
            pos_weird_raider = [[jumpscout]],
            pos_skirmisher = [[jumpskirm]],
            pos_riot = [[jumpblackhole]],
            pos_anti_air = [[jumpaa]],
            pos_assault = [[jumpassault]],
            pos_artillery = [[striderdante]],
            pos_heavy_something = [[jumpsumo]],
            pos_special = [[jumpbomb]]
        },
        metalCost = 800,
        buildDistance = 800,
        script = [[cfactoryjump.lua]],
        yardMap = ""
    },
    factoryspider = {
        buildoptions = {
            [[builder]], [[spiderscout]], [[spiderassault]], [[spideremp]],
            [[spiderriot]], [[spiderskirm]], [[spidercrabe]], [[spideraa]],
            [[spiderantiheavy]], [[cspideranarchid]], [[striderscorpion]]
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[spiderscout]],
            pos_weird_raider = [[spideremp]],
            pos_skirmisher = [[spiderskirm]],
            pos_riot = [[spiderriot]],
            pos_anti_air = [[spideraa]],
            pos_assault = [[spiderassault]],
            pos_artillery = [[cspideranarchid]],
            pos_heavy_something = [[spidercrabe]],
            pos_special = [[spiderantiheavy]],
            pos_utility = [[striderscorpion]]
        },
        metalCost = 800,
        buildDistance = 800,
        script = [[cfactoryspider.lua]],
        yardMap = ""
    },
    factorygunship = {
        buildoptions = {
            [[builder]], [[gunshipbomb]], [[gunshipemp]], [[gunshipraid]],
            [[gunshipskirm]], [[gunshipheavyskirm]], [[gunshipassault]],
            [[gunshipkrow]], [[gunshipaa]], [[dronelight]], [[cnebula]]
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[gunshipraid]],
            pos_weird_raider = [[gunshipemp]],
            pos_skirmisher = [[gunshipskirm]],
            pos_riot = [[gunshipbomb]],
            pos_anti_air = [[gunshipaa]],
            pos_assault = [[gunshipassault]],
            pos_artillery = [[gunshipheavyskirm]],
            pos_heavy_something = [[gunshipkrow]],
            pos_special = [[dronelight]],
            pos_utility = [[cnebula]]

        },
        metalCost = 800,
        buildDistance = 800,
        script = [[cfactorygunship.lua]],
        yardMap = ""
    },
    factoryplane = {
        buildoptions = {
            [[builder]], [[planefighter]], [[planeheavyfighter]],
            [[bomberprec]], [[bomberriot]], [[bomberdisarm]], [[bomberheavy]],
            [[planescout]], [[planelightscout]], [[bomberstrike]]
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[planefighter]],
            pos_weird_raider = [[planeheavyfighter]],
            pos_skirmisher = [[bomberstrike]],
            pos_riot = [[bomberriot]],
            pos_assault = [[bomberprec]],
            pos_artillery = [[planelightscout]],
            pos_heavy_something = [[bomberheavy]],
            pos_special = [[bomberdisarm]],
            pos_utility = [[planescout]]
        },
        metalCost = 800,
        buildDistance = 800,
        script = [[cfactoryplane.lua]],
        yardMap = ""
    },
    chicken = {
        metalCost = 30,
        energyCost = 30,
        buildtime = 30,
        footprintX = 2,
        footprintZ = 2
    },
    chicken_leaper = {
        metalCost = 220,
        energyCost = 220,
        buildtime = 220,
        maxVelocity = 3.2,
        weaponDefs = {WEAPON = {range = 65, impulseBoost = 1250}}
    },
    chickens = {metalCost = 90, energyCost = 90, buildtime = 90},
    chickenwurm = {metalCost = 400, energyCost = 400, buildtime = 400},
    chicken_dodo = {
        metalCost = 60,
        energyCost = 60,
        buildtime = 60,
        footprintX = 3,
        footprintZ = 3
    },
    chickena = {metalCost = 220, energyCost = 220, buildtime = 220},
    chickenc = {metalCost = 400, energyCost = 400, buildtime = 400},
    chicken_roc = {metalCost = 800, energyCost = 800, buildtime = 800},
    chickenf = {
        metalCost = 150,
        energyCost = 150,
        buildtime = 150,
        footprintX = 3,
        footprintZ = 3
    },
    chicken_blimpy = {
        metalCost = 320,
        energyCost = 320,
        buildtime = 320,
        turnRate = 3000,
        turnRadius = 450,
        weaponDefs = {DODOBOMB = {reloadtime = 4}},
        footprintX = 3,
        footprintZ = 3
    },
    chicken_spidermonkey = {
        metalCost = 320,
        energyCost = 320,
        buildtime = 320
    },
    chicken_sporeshooter = {
        metalCost = 410,
        energyCost = 410,
        buildtime = 410
    },
    chickenr = {
        metalCost = 90,
        energyCost = 90,
        buildtime = 90,
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]]
    },
    chicken_shield = {
        metalCost = 300,
        energyCost = 300,
        buildtime = 300,
        weaponDefs = {
            SHIELD = {
                shieldPower = 2000,
                shieldPowerRegen = 30,
                shieldRadius = 100,
                shieldStartingPower = 2000
            }
        }
    },
    chicken_tiamat = {
        metalCost = 900,
        energyCost = 900,
        buildtime = 900,
        weaponDefs = {
            SHIELD = {
                shieldPower = 2000,
                shieldPowerRegen = 30,
                shieldRadius = 100,
                shieldStartingPower = 2000
            }
        }
    },
    chickenblobber = {
        metalCost = 1200,
        energyCost = 1200,
        buildtime = 1200,
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]]
    },
    chicken_dragon = {
        metalCost = 7000,
        energyCost = 7000,
        buildtime = 7000
    },
    cloakbomb = {weaponDefs = {cloakbomb_DEATH = {areaOfEffect = 300}}},
    amphbomb = {weaponDefs = {AMPHBOMB_DEATH = {areaOfEffect = 300}}},
    jumpbomb = {weaponDefs = {jumpbomb_DEATH = {areaOfEffect = 300}}},
    shieldbomb = {weaponDefs = {shieldbomb_DEATH = {areaOfEffect = 300}}},
    dronecarry = {metalCost = 80, maxDamage = 80, reclaimable = true},
    dronelight = {metalCost = 60, maxDamage = 150, reclaimable = true},
    droneheavyslow = {metalCost = 120, maxDamage = 300, reclaimable = true},
    hoverassault = {maxDamage = 1000, maxVelocity = 2.8},
    striderdetriment = {
        selfDestructAs = [[ATOMIC_BLAST]],
        collisionVolumeOffsets = [[0 10 0]],
        collisionVolumeScales = [[92 120 92]],
        customparams = {modelradius = [[40]]}
    },
    staticrearm = {workerTime = 30}
}

return unit_tweaks
