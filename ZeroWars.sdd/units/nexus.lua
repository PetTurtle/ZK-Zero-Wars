unitDef = {
    unitname = [[nexus]],
    name = [[Nexus]],
    description = [[Protect at all cost]],
    acceleration = 0,
    brakeRate = 0,
    buildCostMetal = 10000,
    builder = false,
    buildingGroundDecalDecaySpeed = 30,
    buildingGroundDecalSizeX = 11,
    buildingGroundDecalSizeY = 11,
    buildingGroundDecalType = [[starlight_aoplate.dds]],
    buildPic = [[mahlazer.png]],
    category = [[FLOAT TURRET]],
    collisionVolumeOffsets = [[0 0 0]],
    collisionVolumeScales = [[120 100 120]],
    collisionVolumeType = [[box]],
    corpse = [[DEAD]],
    customParams = {aimposoffset = [[0 15 0]]},
    energyStorage = 1000,
    explodeAs = [[ATOMIC_BLAST]],
    floater = true,
    footprintX = 10,
    footprintZ = 10,
    iconType = [[mahlazer]],
    idleAutoHeal = 5,
    idleTime = 1800,
    maxDamage = 6000,
    maxSlope = 18,
    maxVelocity = 0,
    minCloakDistance = 150,
    noChaseCategory = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
    objectName = [[starlight.dae]],
    script = [[nexus.lua]],
    selfDestructAs = [[ATOMIC_BLAST]],
    sfxtypes = {},
    sightDistance = 730, -- Range*1.1 + 48 for radar overshoot
    turnRate = 0,
    useBuildingGroundDecal = true,
    workerTime = 0,
    yardMap = [[ooo ooo ooo]],
    reclaimable = false,
    canSelfD = false,
    capturable = false,
    weapons = {
        {
            def = [[LASER]],
            badTargetCategory = [[FIXEDWING]],
            onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]]
        },
        {
            def = [[SHIELD]]
        }
    },
    weaponDefs = {
        LASER = {
            name = [[High-Energy Laserbeam]],
            areaOfEffect = 50,
            beamTime = 0.2,
            coreThickness = 0.5,
            craterBoost = 0,
            craterMult = 0,
            customParams = {
                burst = Shared.BURST_UNRELIABLE,
                light_color = [[1.25 1.25 3.75]],
                light_radius = 180
            },
            damage = {default = 600, planes = 900, subs = 45.1},
            explosionGenerator = [[custom:FLASHLAZER]],
            fireStarter = 90,
            fireTolerance = 8192, -- 45 degrees
            impactOnly = true,
            impulseBoost = 1,
            impulseFactor = 1.0,
            interceptedByShieldType = 1,
            largeBeamLaser = true,
            laserFlareSize = 30,
            leadLimit = 18,
            minIntensity = 1,
            noSelfDamage = true,
            projectiles = 1,
            range = 630,
            reloadtime = 0.5,
            rgbColor = [[0 0 1]],
            scrollSpeed = 5,
            soundStart = [[weapon/laser/heavy_laser3]],
            sweepfire = false,
            texture1 = [[largelaser]],
            texture2 = [[flare]],
            texture3 = [[flare]],
            texture4 = [[smallflare]],
            thickness = 25,
            tileLength = 300,
            tolerance = 10000,
            turret = true,
            weaponType = [[BeamLaser]],
            weaponVelocity = 2250
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
            shieldPower = 2500,
            shieldPowerRegen = 16,
            shieldPowerRegenEnergy = 0,
            shieldRadius = 150,
            shieldRepulser = false,
            shieldStartingPower = 2500,
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
            footprintX = 10,
            footprintZ = 10,
            object = [[starlight_dead.dae]]
        },
        HEAP = {
            blocking = false,
            footprintX = 10,
            footprintZ = 10,
            object = [[debris3x3c.s3o]]
        }
    }
}

return lowerkeys({nexus = unitDef})
