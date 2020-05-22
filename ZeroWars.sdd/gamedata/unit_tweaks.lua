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
        }
    },
    chicken = {
        buildcostmetal = 60,
        buildcostenergy = 60,
        buildtime = 60,
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
        buildcostmetal = 110,
        buildcostenergy = 110,
        buildtime = 110
    },
    chickenwurm = {
        buildcostmetal = 400,
        buildcostenergy = 400,
        buildtime = 400
    },
    chicken_dodo = {
        buildcostmetal = 200,
        buildcostenergy = 200,
        buildtime = 200,
        footprintX = 3,
        footprintZ = 3
    },
    chickena = {
        buildcostmetal = 320,
        buildcostenergy = 320,
        buildtime = 320
    },
    chickenc = {
        buildcostmetal = 540,
        buildcostenergy = 540,
        buildtime = 540
    },
    chicken_roc = {
        buildcostmetal = 800,
        buildcostenergy = 800,
        buildtime = 800
    },
    chickenf = {
        buildcostmetal = 420,
        buildcostenergy = 420,
        buildtime = 420,
        footprintX = 3,
        footprintZ = 3
    },
    chicken_blimpy = {
        buildcostmetal = 480,
        buildcostenergy = 480,
        buildtime = 480,
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
        buildcostmetal = 110,
        buildcostenergy = 110,
        buildtime = 110,
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]]
    },
    chicken_shield = {
        buildcostmetal = 400,
        buildcostenergy = 400,
        buildtime = 400,
        weaponDefs = {SHIELD = {shieldPower = 2000, shieldPowerRegen = 30, shieldRadius = 100, shieldStartingPower = 2000}}
    },
    chicken_tiamat = {
        buildcostmetal = 2000,
        buildcostenergy = 2000,
        buildtime = 2000,
        weaponDefs = {
            SHIELD = {shieldPower = 2000, shieldPowerRegen = 30, shieldRadius = 100, shieldStartingPower = 2000}
        }
    },
    chickenblobber = {
        buildcostmetal = 1000,
        buildcostenergy = 1000,
        buildtime = 1000,
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]]
    },
    chicken_dragon = {
        buildcostmetal = 10000,
        buildcostenergy = 10000,
        buildtime = 10000
    },
    cloakbomb = {
        weaponDefs = {cloakbomb_DEATH = {areaOfEffect = 200}}
    },
    amphbomb = {
        weaponDefs = {AMPHBOMB_DEATH = {areaOfEffect = 240}}
    },
    jumpbomb = {
        weaponDefs = {jumpbomb_DEATH = {areaOfEffect = 200}}
    },
    shieldbomb = {
        weaponDefs = {shieldbomb_DEATH = {areaOfEffect = 200}}
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
        buildCostMetal = 110,
        maxDamage = 300,
        reclaimable = true
    },
    bomberstrike = {
        weaponDefs = {MISSILE = {damage = {default = 700, planes = 700}}}
    },
    grebe = {
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]]
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
