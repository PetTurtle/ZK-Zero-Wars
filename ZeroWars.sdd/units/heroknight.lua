return {
    heroknight = {
        unitname = [[heroknight]],
        name = [[Hero Knight]],
        description = [[Hero Assault Bot]],
        acceleration = 0.6,
        brakeRate = 3.6,
        buildCostMetal = 350,
        buildPic = [[cloakassault.png]],
        canGuard = true,
        canMove = true,
        canPatrol = true,
        category = [[LAND]],
        collisionVolumeOffsets = [[0 0 7]],
        collisionVolumeScales = [[35 50 35]],
        collisionVolumeType = [[cylY]],
        selectionVolumeOffsets = [[0 0 0]],
        selectionVolumeScales = [[45 45 45]],
        selectionVolumeType = [[ellipsoid]],
        corpse = [[DEAD]],
        customParams = {
            hero = true,
            modelradius = [[12]],
            cus_noflashlight = 1
        },
        explodeAs = [[BIG_UNITEX]],
        footprintX = 3,
        footprintZ = 3,
        iconType = [[kbotassault]],
        idleAutoHeal = 5,
        idleTime = 1800,
        leaveTracks = true,
        losEmitHeight = 35,
        maxDamage = 3000,
        idleAutoHeal = 50,
        idleTime = 200,
        maxSlope = 36,
        maxVelocity = 1.7,
        maxWaterDepth = 22,
        minCloakDistance = 75,
        movementClass = [[KBOT3]],
        noChaseCategory = [[TERRAFORM FIXEDWING SUB]],
        objectName = [[spherezeus.s3o]],
        script = [[heroknight.lua]],
        selfDestructAs = [[BIG_UNITEX]],
        sfxtypes = {
            explosiongenerators = {
                [[custom:zeusmuzzle]],
                [[custom:zeusgroundflash]]
            }
        },
        sightDistance = 385,
        trackOffset = 0,
        trackStrength = 8,
        trackStretch = 0.8,
        trackType = [[ComTrack]],
        trackWidth = 24,
        turnRate = 1400,
        upright = true,
        canManualFire = true,
        weapons = {
            {
                def = [[MAINLASER]],
                badTargetCategory = [[FIXEDWING]],
                onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]]
            },
            {
                def = [[GAUSS]],
                badTargetCategory = [[FIXEDWING]],
                onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]]
            }
        },
        weaponDefs = {
            MAINLASER = {
                name = [[High Intensity Laserbeam]],
                areaOfEffect = 8,
                beamTime = 0.1,
                coreThickness = 0.5,
                craterBoost = 0,
                craterMult = 0,
                customparams = {
                    stats_hide_damage = 1, -- continuous laser
                    stats_hide_reload = 1,
                    light_color = [[0.25 1 0.25]],
                    light_radius = 120
                },
                damage = {
                    default = 29.68,
                    subs = 1.75
                },
                explosionGenerator = [[custom:flash1green]],
                fireStarter = 30,
                impactOnly = true,
                impulseBoost = 0,
                impulseFactor = 0.4,
                interceptedByShieldType = 1,
                largeBeamLaser = true,
                laserFlareSize = 4.33,
                minIntensity = 1,
                noSelfDamage = true,
                range = 345,
                reloadtime = 0.1,
                rgbColor = [[0 1 0]],
                soundStart = [[weapon/laser/laser_burn10]],
                soundTrigger = true,
                sweepfire = false,
                texture1 = [[largelaser]],
                texture2 = [[flare]],
                texture3 = [[flare]],
                texture4 = [[smallflare]],
                thickness = 4.33,
                tolerance = 18000,
                turret = true,
                weaponType = [[BeamLaser]],
                weaponVelocity = 500
            },
            GAUSS = {
                name = [[Gauss Battery]],
                commandFire = true,
                alphaDecay = 0.12,
                areaOfEffect = 16,
                avoidfeature = false,
                bouncerebound = 0.15,
                bounceslip = 1,
                burst = 3,
                burstrate = 0.2,
                cegTag = [[gauss_tag_h]],
                craterBoost = 0,
                craterMult = 0,
                customParams = {
                    single_hit_multi = true,
                    reaim_time = 1
                },
                damage = {
                    default = 500,
                },
                explosionGenerator = [[custom:gauss_hit_h]],
                groundbounce = 1,
                impactOnly = true,
                impulseBoost = 0,
                impulseFactor = 0,
                interceptedByShieldType = 1,
                noExplode = true,
                noSelfDamage = true,
                numbounce = 40,
                range = 600,
                reloadtime = 1.2,
                rgbColor = [[0.5 1 1]],
                separation = 0.5,
                size = 0.8,
                sizeDecay = -0.1,
                soundHit = [[weapon/gauss_hit]],
                soundStart = [[weapon/gauss_fire]],
                sprayangle = 800,
                stages = 32,
                tolerance = 4096,
                turret = true,
                waterweapon = true,
                weaponType = [[Cannon]],
                weaponVelocity = 900
            }
        },
        featureDefs = {
            DEAD = {
                blocking = true,
                featureDead = [[HEAP]],
                footprintX = 2,
                footprintZ = 2,
                object = [[spherezeus_dead.s3o]]
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
