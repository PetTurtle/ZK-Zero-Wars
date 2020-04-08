return {
    heroduck = {
        unitname = [[heroduck]],
        name = [[Hero Duck]],
        description = [[Hero Duck]],
        acceleration = 0.54,
        activateWhenBuilt = true,
        brakeRate = 2.25,
        buildCostMetal = 80,
        buildPic = [[amphraid.png]],
        canGuard = true,
        canMove = true,
        canPatrol = true,
        category = [[LAND SINK]],
        selectionVolumeOffsets = [[0 0 0]],
        selectionVolumeScales = [[30 30 30]],
        selectionVolumeType = [[ellipsoid]],
        corpse = [[DEAD]],
        customParams = {
            hero = true
        },
        explodeAs = [[BIG_UNITEX]],
        footprintX = 2,
        footprintZ = 2,
        iconType = [[amphtorpraider]],
        idleAutoHeal = 5,
        idleTime = 1800,
        leaveTracks = true,
        maxDamage = 340,
        maxSlope = 36,
        maxVelocity = 3,
        minCloakDistance = 75,
        movementClass = [[AKBOT2]],
        noChaseCategory = [[TERRAFORM FIXEDWING GUNSHIP]],
        objectName = [[amphraider3.s3o]],
        script = [[heroduck.lua]],
        selfDestructAs = [[BIG_UNITEX]],
        sfxtypes = {
            explosiongenerators = {}
        },
        sightDistance = 560,
        trackOffset = 0,
        trackStrength = 8,
        trackStretch = 1,
        trackType = [[ComTrack]],
        trackWidth = 22,
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
                badTargetCategory = [[FIXEDWING GUNSHIP]],
                onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SUB SWIM FLOAT GUNSHIP HOVER]]
            }
        },
        weaponDefs = {
            GRENADE_LAUNCHER = {
                name = [[Grenade Launcher]],
                areaOfEffect = 144,
                burst = 1,
                burstrate = 0.3,
                damage = {
                    default = 200
                },
                edgeEffectiveness = 0.8,
                explosionGenerator = [[custom:EMG_HIT_HE]],
                firestarter = 150,
                impulseBoost = 50,
                impulseFactor = 0.5,
                intensity = 1,
                interceptedByShieldType = 1,
                model = [[wep_b_fabby.s3o]],
                noSelfDamage = true,
                range = 300,
                reloadtime = 1.6,
                soundHit = [[explosion/ex_med6]],
                soundHitVolume = 6,
                soundStart = [[weapon/cannon/outlaw_gun]],
                soundStartVolume = 3,
                turret = true,
                weaponType = [[Cannon]],
                weaponVelocity = 400
            },
            EMP_DGUN = {
                name = [[E.M.P Blast]],
                commandfire = true,
                areaOfEffect = 48,
                craterBoost = 0,
                craterMult = 0,
                damage = {
                    default = 8000
                },
                paralyzer = true,
                paralyzeTime = 8,
                gravityAffected = true,
                explosionGenerator = [[custom:LIGHTNINGPLOSION128AoE]] --[[custom:LIGHTNINGPLOSION]],
                separation = 5,
                impulseBoost = 0,
                impulseFactor = 0,
                interceptedByShieldType = 0,
                leadLimit = 0,
                noExplode = true,
                noSelfDamage = true,
                range = 500,
                reloadtime = 1.5,
                size = 30,
                soundHit = [[weapon/more_lightning_fast]],
                soundStart = [[weapon/LightningBolt]],
                soundTrigger = true,
                turret = true,
                weaponType = [[DGun]],
                weaponVelocity = 600,
                allowNonBlockingAim = true,
                myGravity = 200
            }
        },
        featureDefs = {
            DEAD = {
                blocking = true,
                featureDead = [[HEAP]],
                footprintX = 2,
                footprintZ = 2,
                object = [[amphraider3_dead.s3o]]
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
