local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

unitDef = {
    unitname = [[comduck]],
    name = [[Duck Commander]],
    description = [[Custom Duck Commander]],
    acceleration = 0.54,
    activateWhenBuilt = true,
    brakeRate = 2.25,
    buildCostMetal = 200,
    buildPic = [[amphraid.png]],
    canGuard = true,
    canMove = true,
    canPatrol = true,
    reclaimable = false,
    category = [[LAND]],
    selectionVolumeOffsets = [[0 0 0]],
    selectionVolumeScales = [[30 30 30]],
    selectionVolumeType = [[ellipsoid]],
    corpse = [[DEAD]],
    buildCostMetal = 1000,
    buildDistance = 150,
    builder = true,
    workerTime = 10,
    buildoptions = {
        [[staticmex]],
    },
    customParams = {
        customcom = true
    },
    explodeAs = [[BIG_UNITEX]],
    footprintX = 3,
    footprintZ = 3,
    iconType = [[commander1]],
    idleAutoHeal = 25,
    idleTime = 200,
    leaveTracks = true,
    maxDamage = 825,
    maxSlope = 36,
    maxVelocity = 2.8,
    minCloakDistance = 150,
    movementClass = [[KBOT2]],
    noChaseCategory = [[TERRAFORM FIXEDWING GUNSHIP]],
    objectName = [[amphraider3.s3o]],
    script = [[comduck.lua]],
    selfDestructAs = [[BIG_UNITEX]],
    sfxtypes = {explosiongenerators = {}},
    sightDistance = 560,
    sonarDistance = 560,
    trackOffset = 0,
    trackStrength = 8,
    trackStretch = 1,
    trackType = [[ComTrack]],
    trackWidth = 22,
    turnRate = 1000,
    upright = true,
    weapons = {
        {
            def = [[Torpedo]],
            badTargetCategory = [[FIXEDWING GUNSHIP]],
            onlyTargetCategory = [[SWIM FIXEDWING HOVER LAND SINK TURRET FLOAT SHIP GUNSHIP]]
        },
        {
            def = [[LASER]],
            badTargetCategory = [[FIXEDWING]],
            onlyTargetCategory = [[SWIM FIXEDWING HOVER LAND SINK TURRET FLOAT SHIP GUNSHIP]]
        },
        {
            def = [[MISSILE]],
            badTargetCategory = [[FIXEDWING]],
            onlyTargetCategory = [[SWIM FIXEDWING HOVER LAND SINK TURRET FLOAT SHIP GUNSHIP]]
        }
    },
    weaponDefs = {
        Torpedo = {
            name = [[Torpedo]],
            areaOfEffect = 32,
            cegTag = [[missiletrailyellow]],
            craterBoost = 0,
            craterMult = 0,
            customparams = {
                light_color = [[1 0.6 0.2]],
                light_radius = 180
            },
            damage = {default = 200},
            explosionGenerator = [[custom:INGEBORG]],
            flightTime = 3.5,
            impulseBoost = 0,
            impulseFactor = 0.4,
            interceptedByShieldType = 1,
            leadlimit = 0,
            model = [[wep_m_ajax.s3o]],
            noSelfDamage = true,
            projectiles = 2,
            range = 350,
            reloadtime = 1.0,
            smokeTrail = true,
            soundHit = [[weapon/cannon/cannon_hit2]],
            soundStart = [[weapon/missile/missile_fire9]],
            startVelocity = 140,
            texture2 = [[lightsmoketrail]],
            tracks = true,
            trajectoryHeight = 0.3,
            turnRate = 18000,
            turret = true,
            weaponAcceleration = 90,
            weaponType = [[MissileLauncher]],
            weaponVelocity = 230
        },
        LASER = {
            name = [[High-Energy Laserbeam]],
            areaOfEffect = 14,
            beamTime = 0.8,
            coreThickness = 0.25,
            craterBoost = 0,
            craterMult = 0,
            customParams = {light_color = [[3.75 1.25 1.25]], light_radius = 180},
            damage = {default = 500},
            explosionGenerator = [[custom:flash1orange]],
            fireStarter = 90,
            impactOnly = true,
            impulseBoost = 0,
            impulseFactor = 0.4,
            interceptedByShieldType = 1,
            largeBeamLaser = true,
            laserFlareSize = 4,
            leadLimit = 0,
            minIntensity = 1,
            noSelfDamage = true,
            projectiles = 1,
            range = 450,
            reloadtime = 4.5,
            rgbColor = [[1 0 0]],
            scrollSpeed = 5,
            soundStart = [[weapon/laser/heavy_laser6]],
            soundStartVolume = 4,
            texture1 = [[largelaser]],
            texture2 = [[flare]],
            texture3 = [[flare]],
            texture4 = [[smallflare]],
            thickness = 10.4024486300101,
            tileLength = 300,
            tracks = true,
            turret = true,
            weaponType = [[BeamLaser]],
            weaponVelocity = 2250
        },
        MISSILE = {
            name = [[Grenade Launcher]],
            areaOfEffect = 128,
            accuracy = 512,
            burst = 4,
            burstrate = 0.4,
            cegTag = [[slam_trail]],
            craterBoost = 0,
            craterMult = 0,
            customParams = {
                muzzleEffectFire = [[custom:SLAM_MUZZLE]],
                light_color = [[1 0.8 0.2]],
                light_radius = 380,
            },
            flightTime = 12,
            fireStarter = 100,
            impulseFactor = 0,
            damage = {default = 600,},
            edgeEffectiveness = 0.5,
            explosionGenerator = [[custom:MEDMISSILE_EXPLOSION]],
            interceptedByShieldType = 1,
            model = [[wep_b_fabby.s3o]],
            range = 700,
            reloadtime = 15,
            smokeTrail = false,
            soundHit = [[weapon/bomb_hit]],
            soundStart = [[weapon/missile/missile_fire2]],
            soundStartVolume = 5,
            trajectoryHeight = 1,
            turnRate = 1000,
            turret = true,
            weaponType = [[MissileLauncher]],
            weaponAcceleration = 250,
            weaponVelocity = 250,
            startVelocity = 250,
            wobble = 5000,
            dance = 5,
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

return lowerkeys({comduck = unitDef})
