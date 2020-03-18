local unit_tweaks = {
    chicken_drone_starter = {
        customparams = {
            statsname = nil,
            canmove = true,
            morphto_1 = [[comduck]],
            morphcost_1 = 1,
            morphtime_1 = 1
        }
    },
    chicken = {
        buildcostmetal = 80,
        buildcostenergy = 80,
        buildtime = 80,
        footprintX = 1,
        footprintZ = 2
    },
    chicken_leaper = {
        buildcostmetal = 260,
        buildcostenergy = 260,
        buildtime = 260,
        maxVelocity = 3.2,
        weaponDefs = {
            WEAPON = {
                range = 65,
                impulseBoost = 1250
            }
        }
    },
    chickens = {
        buildcostmetal = 125,
        buildcostenergy = 125,
        buildtime = 125
    },
    chickenwurm = {
        buildcostmetal = 400,
        buildcostenergy = 400,
        buildtime = 400
    },
    chicken_dodo = {
        buildcostmetal = 120,
        buildcostenergy = 120,
        buildtime = 120,
        footprintX = 3,
        footprintZ = 3
    },
    chicken_pigeon = {
        buildcostmetal = 75,
        buildcostenergy = 75,
        buildtime = 75,
        footprintX = 3,
        footprintZ = 2
    },
    chickena = {
        buildcostmetal = 380,
        buildcostenergy = 380,
        buildtime = 380
    },
    chickenc = {
        buildcostmetal = 520,
        buildcostenergy = 520,
        buildtime = 520
    },
    chicken_roc = {
        buildcostmetal = 800,
        buildcostenergy = 800,
        buildtime = 800
    },
    chickenf = {
        buildcostmetal = 340,
        buildcostenergy = 340,
        buildtime = 340,
        footprintX = 3,
        footprintZ = 3
    },
    chicken_blimpy = {
        buildcostmetal = 400,
        buildcostenergy = 400,
        buildtime = 400,
        turnRate = 3000,
        turnRadius = 450,
        weaponDefs = {DODOBOMB = {reloadtime = 8}},
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
        buildcostmetal = 180,
        buildcostenergy = 180,
        buildtime = 180,
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]]
    },
    chicken_shield = {
        buildcostmetal = 1200,
        buildcostenergy = 1200,
        buildtime = 1200
    },
    chicken_tiamat = {
        buildcostmetal = 2800,
        buildcostenergy = 2800,
        buildtime = 2800
    },
    chickenblobber = {
        buildcostmetal = 1300,
        buildcostenergy = 1300,
        buildtime = 1300,
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]]
    },
    chicken_dragon = {
        buildcostmetal = 12000,
        buildcostenergy = 12000,
        buildtime = 12000
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
        buildCostMetal = 70,
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
