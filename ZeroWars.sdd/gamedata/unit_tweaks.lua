local unit_tweaks = {
    factorycloak = {
        buildoptions  = {
            [[builder]],
            [[cloakraid]],
            [[cloakheavyraid]],
            [[cloakskirm]],
            [[cloakriot]],
            [[cloakassault]],
            [[cloakarty]],
            [[cloaksnipe]],
            [[cloakaa]],
            [[cloakbomb]],
            [[striderantiheavy]],
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[cloakraid]],
            pos_weird_raider = [[cloakheavyraid]],
            pos_skirmisher = [[cloakskirm]],
            pos_riot = [[cloakriot]],
            pos_anti_air = [[cloakaa]],
            pos_assault = [[cloakassault]],
            pos_artillery= [[cloakarty]],
            pos_heavy_something = [[cloaksnipe]],
            pos_special = [[cloakbomb]],
            pos_utility = [[striderantiheavy]],
        },
        buildCostMetal = 800,
        buildDistance = 800,
        script = [[cfactorycloak.lua]],
        yardMap = "",
    },
    factoryshield = {
        buildoptions  = {
            [[builder]]
        },
        customParams = {
            pos_constructor = [[builder]],
        },
        buildCostMetal = 800,
        buildDistance = 800,
        script = [[cfactoryshield.lua]],
        yardMap = "",
    },
    factoryveh = {
        buildoptions  = {
            [[builder]]
        },
        customParams = {
            pos_constructor = [[builder]],
        },
        buildCostMetal = 800,
        buildDistance = 800,
        script = [[cfactoryveh.lua]],
        yardMap = "",
    },
    factorytank = {
        buildoptions  = {
            [[builder]],
            [[tankraid]],
            [[tankheavyraid]],
            [[tankriot]],
            [[tankarty]],
            [[striderarty]],
            [[tankaa]],
            [[tankassault]],
            [[tankheavyassault]],
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
            pos_utility = [[striderarty]],
        },
        buildCostMetal = 800,
        buildDistance = 800,
        script = [[cfactorytank.lua]],
        yardMap = "",
    },
    factoryhover = {
        buildoptions  = {
            [[builder]],
            [[hoverraid]],
            [[hoverheavyraid]],
            [[hoverdepthcharge]],
            [[hoverriot]],
            [[hoverskirm]],
            [[hoverarty]],
            [[hoveraa]],
            [[hoverassault]],
            [[hoverminer]],
            [[hovershotgun]],
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
            pos_utility = [[hoverminer]],
        },
        buildCostMetal = 800,
        buildDistance = 800,
        script = [[cfactoryhover.lua]],
        yardMap = "",
    },
    factoryamph = {
        buildoptions  = {
            [[builder]],
            [[amphraid]],
            [[amphimpulse]],
            [[amphfloater]],
            [[amphriot]],
            [[amphassault]],
            [[grebe]],
            [[amphaa]],
            [[amphbomb]],
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[amphraid]],
            pos_weird_raider = [[amphimpulse]],
            pos_skirmisher = [[amphfloater]],
            pos_riot = [[amphriot]],
            pos_anti_air = [[amphaa]],
            pos_assault = [[grebe]],
            pos_heavy_something = [[amphassault]],
            pos_special = [[amphbomb]],
        },
        buildCostMetal = 800,
        buildDistance = 800,
        script = [[cfactoryamph.lua]],
        yardMap = "",
    },
    factoryjump = {
        buildoptions  = {
            [[builder]]
        },
        customParams = {
            pos_constructor = [[builder]],
        },
        buildCostMetal = 800,
        buildDistance = 800,
        script = [[cfactoryjump.lua]],
        yardMap = "",
    },
    factoryspider = {
        buildoptions  = {
            [[builder]],
            [[spiderscout]],
            [[spiderassault]],
            [[spideremp]],
            [[spiderriot]],
            [[spiderskirm]],
            [[spidercrabe]],
            [[spideraa]],
            [[spiderantiheavy]],
            [[spideranarchid]],
        },
        customParams = {
            pos_constructor = [[builder]],
            pos_raider = [[spiderscout]],
            pos_weird_raider = [[spideremp]],
            pos_skirmisher = [[spiderskirm]],
            pos_riot = [[spiderriot]],
            pos_anti_air = [[spideraa]],
            pos_assault = [[spiderassault]],
            pos_artillery = [[spideranarchid]],
            pos_heavy_something = [[spidercrabe]],
            pos_special = [[spiderantiheavy]],
        },
        buildCostMetal = 800,
        buildDistance = 800,
        script = [[cfactoryspider.lua]],
        yardMap = "",
    },
    factorygunship = {
        buildoptions  = {
            [[builder]],
            [[gunshipbomb]],
            [[gunshipemp]],
            [[gunshipraid]],
            [[gunshipskirm]],
            [[gunshipheavyskirm]],
            [[gunshipassault]],
            [[gunshipkrow]],
            [[gunshipaa]],
            [[dronelight]],
            [[nebula]],
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
            pos_utility = [[nebula]],

        },
        buildCostMetal = 800,
        buildDistance = 800,
        script = [[cfactorygunship.lua]],
        yardMap = "",
    },
    factoryplane = {
        buildoptions  = {
            [[builder]],
            [[planefighter]],
            [[planeheavyfighter]],
            [[bomberprec]],
            [[bomberriot]],
            [[bomberdisarm]],
            [[bomberheavy]],
            [[planescout]],
            [[planelightscout]],
            [[bomberstrike]],
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
            pos_utility = [[planescout]],
        },
        buildCostMetal = 800,
        buildDistance = 800,
        script = [[cfactoryplane.lua]],
        yardMap = "",
    },
    chicken = {
        buildcostmetal = 25,
        buildcostenergy = 25,
        buildtime = 25,
        footprintX = 2,
        footprintZ = 2
    },
    chicken_leaper = {
        buildcostmetal = 220,
        buildcostenergy = 220,
        buildtime = 220,
        maxVelocity = 3.2,
        weaponDefs = {
            WEAPON = {
                range = 65,
                impulseBoost = 1250
            }
        }
    },
    chickens = {
        buildcostmetal = 90,
        buildcostenergy = 90,
        buildtime = 90
    },
    chickenwurm = {
        buildcostmetal = 400,
        buildcostenergy = 400,
        buildtime = 400
    },
    chicken_dodo = {
        buildcostmetal = 75,
        buildcostenergy = 75,
        buildtime = 75,
        footprintX = 3,
        footprintZ = 3
    },
    chickena = {
        buildcostmetal = 220,
        buildcostenergy = 220,
        buildtime = 220
    },
    chickenc = {
        buildcostmetal = 350,
        buildcostenergy = 350,
        buildtime = 350
    },
    chicken_roc = {
        buildcostmetal = 800,
        buildcostenergy = 800,
        buildtime = 800
    },
    chickenf = {
        buildcostmetal = 150,
        buildcostenergy = 150,
        buildtime = 150,
        footprintX = 3,
        footprintZ = 3
    },
    chicken_blimpy = {
        buildcostmetal = 300,
        buildcostenergy = 300,
        buildtime = 300,
        turnRate = 3000,
        turnRadius = 450,
        weaponDefs = {DODOBOMB = {reloadtime = 4}},
        footprintX = 3,
        footprintZ = 3
    },
    chicken_spidermonkey = {
        buildcostmetal = 320,
        buildcostenergy = 320,
        buildtime = 320
    },
    chicken_sporeshooter = {
        buildcostmetal = 410,
        buildcostenergy = 410,
        buildtime = 410
    },
    chickenr = {
        buildcostmetal = 90,
        buildcostenergy = 90,
        buildtime = 90,
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]]
    },
    chicken_shield = {
        buildcostmetal = 600,
        buildcostenergy = 600,
        buildtime = 600,
        weaponDefs = {SHIELD = {shieldPower = 2000, shieldPowerRegen = 30, shieldRadius = 100, shieldStartingPower = 2000}}
    },
    chicken_tiamat = {
        buildcostmetal = 1000,
        buildcostenergy = 1000,
        buildtime = 1000,
        weaponDefs = {
            SHIELD = {shieldPower = 2000, shieldPowerRegen = 30, shieldRadius = 100, shieldStartingPower = 2000}
        }
    },
    chickenblobber = {
        buildcostmetal = 1500,
        buildcostenergy = 1500,
        buildtime = 1500,
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]]
    },
    chicken_dragon = {
        buildcostmetal = 8000,
        buildcostenergy = 8000,
        buildtime = 8000
    },
    cloakbomb = {
        weaponDefs = {cloakbomb_DEATH = {areaOfEffect = 300}}
    },
    amphbomb = {
        weaponDefs = {AMPHBOMB_DEATH = {areaOfEffect = 300}}
    },
    jumpbomb = {
        weaponDefs = {jumpbomb_DEATH = {areaOfEffect = 300}}
    },
    shieldbomb = {
        weaponDefs = {shieldbomb_DEATH = {areaOfEffect = 300}}
    },
    dronecarry = {
        buildCostMetal = 80,
        maxDamage = 80,
        reclaimable = true
    },
    dronelight = {
        buildCostMetal = 50,
        maxDamage = 150,
        reclaimable = true
    },
    droneheavyslow = {
        buildCostMetal = 120,
        maxDamage = 300,
        reclaimable = true
    },
    bomberstrike = {
        weaponDefs = {MISSILE = {damage = {default = 700, planes = 700}}}
    },
    grebe = {
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]]
    },
    spideranarchid = {
        weaponDefs = {
            LASER = {
                range = 400,
            }
        }
    },
    hoverassault = {
        maxDamage = 1000,
        maxVelocity = 2.8
    },
    nebula = {
        footprintX = 5,
        footprintZ = 15,
        weaponDefs = {CANNON = {areaOfEffect = 150, damage = {default = 50}}}
    },
    striderdetriment = {
        selfDestructAs = [[ATOMIC_BLAST]],
        collisionVolumeOffsets = [[0 10 0]],
        collisionVolumeScales = [[92 120 92]],
        customparams = {modelradius = [[40]]}
    },
    staticrearm = {
        workerTime = 30
    }
}

return unit_tweaks