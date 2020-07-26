unitDef = {
    unitname = [[nexusturret]],
    name = [[Turret]],
    description = [[Nexus Turret]],
    activateWhenBuilt = true,
    buildCostMetal = 700,
    builder = false,
    buildingGroundDecalDecaySpeed = 30,
    buildingGroundDecalSizeX = 5,
    buildingGroundDecalSizeY = 5,
    buildingGroundDecalType = [[turretsunlance_decal.dds]],
    buildPic = [[turretsunlance.png]],
    canGuard = true,
    category = [[FLOAT TURRET]],
    corpse = [[DEAD]],
    explodeAs = [[LARGE_BUILDINGEX]],
    floater = true,
    footprintX = 4,
    footprintZ = 4,
    iconType = [[staticassault]],
    levelGround = false,
    maxDamage = 5600,
    maxSlope = 18,
    minCloakDistance = 150,
    noAutoFire = false,
    noChaseCategory = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
    objectName = [[heavyturret.s3o]],
    script = [[nexusturret.lua]],
    selfDestructAs = [[LARGE_BUILDINGEX]],
    reclaimable = false,
    canSelfD = false,
    capturable = false,
    sfxtypes = {
        explosiongenerators = {
            [[custom:none]]
        }
    },
    sightDistance = 450,
    useBuildingGroundDecal = true,
    workerTime = 0,
    yardMap = [[oooo oooo oooo oooo]],
    weapons = {
        {
            def = [[DISRUPTOR]],
            badTargetCategory = [[FIXEDWING]],
            onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]]
        },
        {
            def = [[SHIELD]]
        }
    },
    weaponDefs = {
        DISRUPTOR = {
            name = [[Disruptor Pulse Beam]],
            areaOfEffect = 64,
            beamdecay = 0.9,
            beamTime = 1 / 30,
            beamttl = 30,
            coreThickness = 0.3,
            craterBoost = 0,
            craterMult = 0.25,
            customParams = {
                timeslow_damage = [[1000]]
            },
            damage = {
                default = 500
            },
            explosionGenerator = [[custom:flash2purple]],
            fireStarter = 30,
            impulseBoost = 0,
            impulseFactor = 0.4,
            interceptedByShieldType = 1,
            largeBeamLaser = true,
            laserFlareSize = 4.33,
            minIntensity = 1,
            noSelfDamage = true,
            range = 450,
            reloadtime = 1.5,
            rgbColor = [[0.3 0 0.4]],
            soundStart = [[weapon/laser/heavy_laser5]],
            soundStartVolume = 5,
            soundTrigger = true,
            sweepfire = false,
            texture1 = [[largelaser]],
            texture2 = [[flare]],
            texture3 = [[flare]],
            texture4 = [[smallflare]],
            thickness = 16,
            tolerance = 18000,
            turret = true,
            weaponType = [[BeamLaser]],
            weaponVelocity = 500
        },
        SHIELD = {
            name = [[Energy Shield]],
            damage = {
                default = 10
            },
            exteriorShield = true,
            shieldAlpha = 0.2,
            shieldBadColor = [[1 0.1 0.1 1]],
            shieldGoodColor = [[0.1 0.1 1 1]],
            shieldInterceptType = 3,
            shieldPower = 1250,
            shieldPowerRegen = 16,
            shieldPowerRegenEnergy = 0,
            shieldRadius = 80,
            shieldRepulser = false,
            shieldStartingPower = 1250,
            smartShield = true,
            visibleShield = true,
            visibleShieldRepulse = false,
            weaponType = [[Shield]]
        }
    },
    featureDefs = {
        DEAD = {
            blocking = true,
            featureDead = [[HEAP]],
            footprintX = 3,
            footprintZ = 3,
            object = [[heavyturret_dead.s3o]]
        },
        HEAP = {
            blocking = false,
            footprintX = 3,
            footprintZ = 3,
            object = [[debris4x4b.s3o]]
        }
    }
}

return lowerkeys({nexusturret = unitDef})
