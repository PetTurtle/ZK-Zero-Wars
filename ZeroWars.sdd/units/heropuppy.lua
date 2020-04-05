return {
    heropuppy = {
        unitname = [[heropuppy]],
        name = [[Hero Puppy]],
        description = [[Hero Walking Missile]],
        acceleration = 0.72,
        activateWhenBuilt = true,
        brakeRate = 4.32,
        buildCostMetal = 45,
        builder = false,
        buildPic = [[jumpscout.png]],
        canGuard = true,
        canMove = true,
        canPatrol = true,
        category = [[LAND TOOFAST]],
        collisionVolumeOffsets = [[0 0 0]],
        collisionVolumeScales = [[20 20 20]],
        collisionVolumeType = [[ellipsoid]],
        selectionVolumeOffsets = [[0 0 0]],
        selectionVolumeScales = [[28 28 28]],
        selectionVolumeType = [[ellipsoid]],
        customParams = {
            hero = true,
            modelradius = [[10]]
        },
        explodeAs = [[TINY_BUILDINGEX]],
        footprintX = 2,
        footprintZ = 2,
        iconType = [[kbotbomb]],
        idleAutoHeal = 5,
        idleTime = 1800,
        leaveTracks = true,
        maxDamage = 80,
        maxSlope = 36,
        maxVelocity = 3.5,
        maxWaterDepth = 15,
        minCloakDistance = 75,
        movementClass = [[SKBOT2]],
        noAutoFire = false,
        noChaseCategory = [[FIXEDWING]],
        objectName = [[puppy.s3o]],
        script = [[heropuppy.lua]],
        selfDestructAs = [[TINY_BUILDINGEX]],
        selfDestructCountdown = 5,
        sfxtypes = {
            explosiongenerators = {
                [[custom:RAIDMUZZLE]],
                [[custom:VINDIBACK]],
                [[custom:digdig]]
            }
        },
        sightDistance = 640,
        trackOffset = 0,
        trackStrength = 8,
        trackStretch = 0.6,
        trackType = [[ComTrack]],
        trackWidth = 12,
        turnRate = 1800,
        canManualFire = true,
        reclaimable = false,
        canSelfD = false,
        capturable = false,
        weapons = {
            {
                def = [[MISSILE]],
                badTargetCategory = [[UNARMED]],
                onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]]
            },
            {
                def = [[SPAWNERMISSILE]],
                onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]]
            }
        },
        weaponDefs = {
            MISSILE = {
                name = [[Legless Puppy]],
                areaOfEffect = 40,
                cegTag = [[VINDIBACK]],
                craterBoost = 1,
                craterMult = 2,
                customParams = {
                    burst = Shared.BURST_RELIABLE
                },
                damage = {
                    default = 410.1
                },
                fireStarter = 70,
                flightTime = 0.8,
                impulseBoost = 0.75,
                impulseFactor = 0.3,
                interceptedByShieldType = 2,
                model = [[puppymissile.s3o]],
                noSelfDamage = true,
                range = 170,
                reloadtime = 1.5,
                smokeTrail = false,
                soundHit = [[explosion/ex_med5]],
                soundHitVolume = 8,
                soundStart = [[weapon/missile/sabot_fire]],
                soundStartVolume = 7,
                startVelocity = 300,
                tracks = true,
                turnRate = 56000,
                turret = true,
                weaponAcceleration = 300,
                weaponType = [[MissileLauncher]],
                weaponVelocity = 400
            },
            SPAWNERMISSILE = {
                name = [[Legless Puppy]],
                commandFire = true,
                areaOfEffect = 40,
                cegTag = [[VINDIBACK]],
                burst = 8,
                burstrate = 0.2,
                accuracy = 500,
                sprayAngle = 1180,
                customParams = {
                    burst = Shared.BURST_RELIABLE,
                    spawns_name = "jumpscout",
                    spawns_expire = 60,
                    spawn_blocked_by_shield = 1
                },
                damage = {
                    default = 410.1,
                    planes = 410.1,
                    subs = 20.5
                },
                fireStarter = 70,
                flightTime = 0.8,
                impulseBoost = 0.75,
                impulseFactor = 0.3,
                interceptedByShieldType = 1,
                model = [[puppymissile.s3o]],
                noSelfDamage = true,
                range = 250,
                reloadtime = 1.5,
                smokeTrail = false,
                soundHit = [[explosion/ex_med5]],
                soundHitVolume = 8,
                soundStart = [[weapon/missile/sabot_fire]],
                soundStartVolume = 7,
                startVelocity = 300,
                tracks = true,
                turnRate = 56000,
                turret = true,
                weaponAcceleration = 300,
                weaponType = [[MissileLauncher]],
                weaponVelocity = 400
            }
        },
        featureDefs = {
            DEAD = {
                blocking = false,
                featureDead = [[HEAP]],
                footprintX = 3,
                footprintZ = 3,
                object = [[debris2x2a.s3o]]
            },
            HEAP = {
                blocking = false,
                footprintX = 2,
                footprintZ = 2,
                object = [[debris2x2c.s3o]]
            }
        }
    }
}
