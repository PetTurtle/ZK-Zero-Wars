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
        buildcostmetal = 50,
        buildcostenergy = 50,
        buildtime = 50,
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
        buildcostmetal = 180,
        buildcostenergy = 180,
        buildtime = 180,
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
        buildcostmetal = 300,
        buildcostenergy = 300,
        buildtime = 300,
        weaponDefs = {SHIELD = {shieldPower = 2000, shieldPowerRegen = 30, shieldRadius = 100, shieldStartingPower = 2000}}
    },
    chicken_tiamat = {
        buildcostmetal = 700,
        buildcostenergy = 700,
        buildtime = 700,
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
        buildcostmetal = 6000,
        buildcostenergy = 6000,
        buildtime = 6000
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
