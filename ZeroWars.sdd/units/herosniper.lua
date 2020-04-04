return {
    herosniper = {
        unitname = [[herosniper]],
        name = [[Hero Phantom]],
        description = [[Hero Sniper Bot]],
        acceleration = 0.9,
        brakeRate = 1.2,
        buildCostMetal = 750,
        buildPic = [[cloaksnipe.png]],
        canGuard = true,
        canMove = true,
        canPatrol = true,
        category = [[LAND]],
        cloakCost = 1,
        cloakCostMoving = 5,
        collisionVolumeOffsets = [[0 0 0]],
        collisionVolumeScales = [[30 60 30]],
        collisionVolumeType = [[cylY]],
        selectionVolumeOffsets = [[0 0 0]],
        selectionVolumeScales = [[45 45 45]],
        selectionVolumeType = [[ellipsoid]],
        corpse = [[DEAD]],
        customParams = {
            hero = true,
            modelradius = [[15]],
            dontfireatradarcommand = "0"
        },
        decloakOnFire = false,
        explodeAs = [[BIG_UNITEX]],
        footprintX = 3,
        footprintZ = 3,
        iconType = [[sniper]],
        idleAutoHeal = 5,
        idleTime = 1800,
        leaveTracks = true,
        losEmitHeight = 40,
        initCloaked = true,
        maxDamage = 560,
        maxSlope = 36,
        maxVelocity = 1.4,
        maxWaterDepth = 22,
        minCloakDistance = 155,
        movementClass = [[KBOT3]],
        noChaseCategory = [[TERRAFORM FIXEDWING GUNSHIP SUB]],
        objectName = [[sharpshooter.s3o]],
        script = [[herosniper.lua]],
        selfDestructAs = [[BIG_UNITEX]],
        sfxtypes = {
            explosiongenerators = {
                [[custom:WEAPEXP_PUFF]],
                [[custom:MISSILE_EXPLOSION]]
            }
        },
        sightDistance = 400,
        trackOffset = 0,
        trackStrength = 8,
        trackStretch = 1,
        trackType = [[ComTrack]],
        trackWidth = 22,
        turnRate = 2200,
        upright = true,
        canManualFire = true,
        weapons = {
            {
                def = [[GAUSS]],
                badTargetCategory = [[FIXEDWING]],
                onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SUB SHIP SWIM FLOAT GUNSHIP HOVER]]
            },
            {
                def = [[SHOCKRIFLE]],
                badTargetCategory = [[FIXEDWING]],
                onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]]
            }
        },
        weaponDefs = {
            GAUSS = {
                name = [[Light Gauss Cannon]],
                alphaDecay = 0.12,
                areaOfEffect = 16,
                avoidfeature = false,
                bouncerebound = 0.15,
                bounceslip = 1,
                cegTag = [[gauss_tag_l]],
                craterBoost = 0,
                craterMult = 0,
                customParams = {
                    burst = Shared.BURST_RELIABLE,
                    single_hit = true
                },
                damage = {
                    default = 200.1,
                    planes = 200.1
                },
                explosionGenerator = [[custom:gauss_hit_m]],
                groundbounce = 1,
                impactOnly = true,
                impulseBoost = 0,
                impulseFactor = 0,
                interceptedByShieldType = 1,
                noExplode = true,
                noSelfDamage = true,
                numbounce = 40,
                range = 560,
                reloadtime = 2,
                rgbColor = [[0.5 1 1]],
                separation = 0.5,
                size = 0.8,
                sizeDecay = -0.1,
                soundHit = [[weapon/gauss_hit]],
                soundHitVolume = 3,
                soundStart = [[weapon/gauss_fire]],
                soundStartVolume = 2.5,
                stages = 32,
                turret = true,
                waterweapon = true,
                weaponType = [[Cannon]],
                weaponVelocity = 1200
            },
            SHOCKRIFLE = {
                name = [[Pulsed Particle Projector]],
                commandFire = true,
                areaOfEffect = 16,
                colormap = [[0 0 0.4 0   0 0 0.6 0.3   0 0 0.8 0.6   0 0 0.9 0.8   0 0 1 1   0 0 1 1]],
                craterBoost = 0,
                craterMult = 0,
                customParams = {
                    burst = Shared.BURST_RELIABLE,
                    light_radius = 0,
                    restrict_in_widgets = 1
                },
                damage = {
                    default = 2500
                },
                explosionGenerator = [[custom:spectre_hit]],
                fireTolerance = 512, -- 2.8 degrees
                impactOnly = true,
                impulseBoost = 0,
                impulseFactor = 0.4,
                interceptedByShieldType = 1,
                noSelfDamage = true,
                range = 700,
                reloadtime = 17,
                rgbColor = [[1 0.2 0.2]],
                separation = 1.5,
                size = 5,
                sizeDecay = 0,
                soundHit = [[weapon/laser/heavy_laser6]],
                soundStart = [[weapon/gauss_fire]],
                turret = true,
                weaponType = [[Cannon]],
                weaponVelocity = 850
            }
        },
        featureDefs = {
            DEAD = {
                blocking = true,
                featureDead = [[HEAP]],
                footprintX = 2,
                footprintZ = 2,
                object = [[sharpshooter_dead.s3o]]
            },
            HEAP = {
                blocking = false,
                footprintX = 2,
                footprintZ = 2,
                object = [[debris2x2b.s3o]]
            }
        }
    }
}
