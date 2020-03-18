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
        buildcostmetal = 100,
        buildcostenergy = 100,
        buildtime = 100
    },
    chicken_leaper = {
        buildcostmetal = 130,
        buildcostenergy = 130,
        buildtime = 130,
        weaponDefs = {WEAPON = {impulseBoost = 1000}}
    },
    chickens = {
        buildcostmetal = 150,
        buildcostenergy = 150,
        buildtime = 150
    },
    chicken_dodo = {
        buildcostmetal = 120,
        buildcostenergy = 120,
        buildtime = 120
    },
    chicken_pigeon = {
        buildcostmetal = 75,
        buildcostenergy = 75,
        buildtime = 75,
        footprintX = 3,
        footprintZ = 2
    },
    chickena = {
        buildcostmetal = 400,
        buildcostenergy = 400,
        buildtime = 400
    },
    chickenc = {
        buildcostmetal = 520,
        buildcostenergy = 520,
        buildtime = 520
    },
    chicken_blimpy = {
        buildcostmetal = 520,
        buildcostenergy = 520,
        buildtime = 520
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
        collisionVolumeOffsets = [[0 10 0]],
        collisionVolumeScales = [[92 120 92]],
        customParams = {modelradius = [[40]]}
    }
}

return unit_tweaks
