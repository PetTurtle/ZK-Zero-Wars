unitDef = {
    unitname                      = [[factorychickenadv]],
    name                          = [[Advanced Chicken Factory]],
    description                   = [[Builds at 10 m/s]],
    acceleration                  = 0,
    brakeRate                     = 1.5,
    buildCostMetal                = 400,
    buildDistance                 = 800,
    builder                       = true,
    buildingGroundDecalDecaySpeed = 30,
    buildingGroundDecalSizeX      = 8,
    buildingGroundDecalSizeY      = 8,
    buildingGroundDecalType       = [[factorycloak_aoplane.dds]],
  
    buildoptions                  = {
      [[chicken]], -- chicken
      [[chickens]], -- Spiker
      [[chicken_dodo]], -- dodo
      [[chicken_spidermonkey]], -- spidermonkey
      [[chickenf]], -- Talon
      [[chickenr]], -- Lobber
      
      [[chicken_blimpy]], -- Blimpy
      [[chickenc]],
      [[chickena]],
      [[chickenblobber]],
      [[chicken_shield]],
      [[chicken_tiamat]],
      [[chicken_dragon]], -- White Dragon
    },
  
    buildPic                      = [[chickenflyerqueen.png]],
    canGuard                      = true,
    canMove                       = false,
    canPatrol                     = true,
    cantBeTransported             = true,
    category                      = [[FLOAT UNARMED]],
    collisionVolumeOffsets        = [[0 0 0]],
    collisionVolumeScales         = [[70 70 70]],
    collisionVolumeType           = [[ellipsoid]],
    corpse                        = [[DEAD]],
  
    customParams                  = {
    },
  
    explodeAs                     = [[ESTOR_BUILDINGEX]],
    floater                       = true,
    footprintX                    = 8,
    footprintZ                    = 8,
    iconType                      = [[fackbot]],
    idleAutoHeal                  = 5,
    idleTime                      = 1800,
    levelGround                   = false,
    maneuverleashlength           = [[380]],
    maxDamage                     = 2000,
    maxSlope                      = 15,
    maxVelocity                   = 0,
    minCloakDistance              = 150,
    movementClass                 = [[KBOT4]],
    noAutoFire                    = false,
    objectName                    = [[chickenflyerqueen.s3o]],
    script                        = [[customFactoryChickenQ.lua]],
    selfDestructAs                = [[SMALL_UNITEX]],
    showNanoSpray                 = true,
    sightDistance                 = 380,
    turnRate                      = 1,
    upright                       = true,
    useBuildingGroundDecal        = true,
    workerTime                    = 10,
  
    featureDefs                   = {
  
      DEAD = {
        blocking         = false,
        featureDead      = [[HEAP]],
        footprintX       = 7,
        footprintZ       = 7,
        object           = [[cremfactorywreck.s3o]],
      },
  
  
      HEAP = {
        blocking         = false,
        footprintX       = 7,
        footprintZ       = 7,
        object           = [[debris4x4b.s3o]],
      },
  
    },
  
  }
  
  return lowerkeys({factorychickenadv = unitDef})