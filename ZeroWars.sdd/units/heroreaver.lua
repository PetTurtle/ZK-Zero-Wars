return {
    heroreaver = {
        unitname = [[heroreaver]],
        name = [[Hero Reaver]],
        description = [[Hero Riot Bot]],
        acceleration = 0.75,
        brakeRate = 1.2,
        buildCostMetal = 220,
        buildPic = [[cloakriot.png]],
        canGuard = true,
        canMove = true,
        canPatrol = true,
        category = [[LAND]],
        collisionVolumeOffsets = [[0 1 -1]],
        collisionVolumeScales = [[26 36 26]],
        collisionVolumeType = [[cylY]],
        selectionVolumeOffsets = [[0 0 0]],
        selectionVolumeScales = [[45 45 45]],
        selectionVolumeType = [[ellipsoid]],
        corpse = [[DEAD]],
        customParams = {
            hero = true,
            modelradius = [[7]],
            cus_noflashlight = 1,
            selection_scale = 0.85
        },
        explodeAs = [[SMALL_UNITEX]],
        footprintX = 3,
        footprintZ = 3,
        iconType = [[kbotriot]],
        idleAutoHeal = 20,
        idleTime = 150,
        leaveTracks = true,
        maxDamage = 2000,
        maxSlope = 36,
        maxVelocity = 1.71,
        maxWaterDepth = 22,
        minCloakDistance = 75,
        movementClass = [[KBOT3]],
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]],
        objectName = [[Spherewarrior.s3o]],
        script = [[heroreaver.lua]],
        selfDestructAs = [[SMALL_UNITEX]],
        sfxtypes = {
            explosiongenerators = {
                [[custom:WARMUZZLE]],
                [[custom:emg_shells_l]]
            }
        },
        sightDistance = 350,
        trackOffset = 0,
        trackStrength = 8,
        trackStretch = 0.8,
        trackType = [[ComTrack]],
        trackWidth = 20,
        turnRate = 1800,
        upright = true,
        canManualFire = true,
        reclaimable = false,
        canSelfD = false,
        capturable = false,
        weapons = {
            {
                def = [[GRENADE_LAUNCHER]],
                badTargetCategory = [[FIXEDWING]],
                onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]]
            },
            {
                def = [[EMP_DGUN]],
                badTargetCategory = [[FIXEDWING]],
                onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]]
            }
        },
        weaponDefs = {
            GRENADE_LAUNCHER = {
                name = [[Grenade Launcher]],
                accuracy = 400,
                areaOfEffect = 250,
                burnblow = true,
                burst = 1,
                burstrate = 0.3,
                damage = {
                    default = 120
                },
                edgeEffectiveness = 0.8,
                explosionGenerator = [[custom:EMG_HIT_HE]],
                firestarter = 70,
                impulseBoost = 50,
                intensity = 1,
                interceptedByShieldType = 1,
                model = [[wep_b_fabby.s3o]],
                noSelfDamage = true,
                range = 275,
                reloadtime = 1.2,
                soundHit = [[explosion/ex_med6]],
                soundHitVolume = 6,
                soundStart = [[weapon/cannon/mini_cannon]],
                soundStartVolume = 2,
                turret = true,
                weaponType = [[Cannon]],
                weaponVelocity = 230
            },
            EMP_DGUN = {
                name = [[E.M.P Blast]],
                commandFire = true,
                areaOfEffect = 160,
                burst = 20,
                burstRate = 0.08,
                craterBoost = 0,
                craterMult = 0,
                customParams = {
                    light_color = [[0.75 0.75 0.56]],
                    light_radius = 220
                },
                damage = {
                    default = 1200
                },
                duration = 8,
                edgeEffectiveness = 0.8,
                explosionGenerator = [[custom:YELLOW_LIGHTNINGPLOSION]],
                fireStarter = 0,
                impulseBoost = 0,
                impulseFactor = 0,
                intensity = 12,
                interceptedByShieldType = 1,
                noSelfDamage = true,
                paralyzer = true,
                paralyzeTime = 6,
                range = 200,
                reloadtime = 2.7,
                sprayAngle = 2048,
                rgbColor = [[1 1 0.25]],
                soundStart = [[weapon/lightning_fire]],
                soundTrigger = true,
                texture1 = [[lightning]],
                thickness = 10,
                turret = true,
                weaponType = [[LightningCannon]],
                weaponVelocity = 450
            }
        },
        featureDefs = {
            DEAD = {
                blocking = true,
                featureDead = [[HEAP]],
                footprintX = 2,
                footprintZ = 2,
                object = [[spherewarrior_dead.s3o]]
            },
            HEAP = {
                blocking = false,
                footprintX = 2,
                footprintZ = 2,
                object = [[debris3x3a.s3o]]
            }
        }
    }
}
