unitDef = {
    unitname                      = [[factorylight]],
    name                          = [[Light Factory]],
    description                   = [[Builds at 10 m/s]],
    acceleration                  = 0,
    brakeRate                     = 1.5,
    buildCostMetal                = 400,
    buildDistance                 = 800,
    builder                       = true,
    buildingGroundDecalDecaySpeed = 30,
    buildingGroundDecalSizeX      = 13,
    buildingGroundDecalSizeY      = 13,
    buildingGroundDecalType       = [[factorycloak_aoplane.dds]],
  
    buildoptions                  = {
      [[grebe]],
      [[vehsupport]],
      [[cloakriot]],
      [[shieldassault]],
      [[shieldskirm]],
      [[cloakbomb]],
      [[cloakaa]],
    },
  
    buildPic                      = [[factorycloak.png]],
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
      morphto = [[factorylightadv]],
      morphcost = 800,
    },
  
    explodeAs                     = [[ESTOR_BUILDINGEX]],
    floater                       = true,
    footprintX                    = 7,
    footprintZ                    = 10,
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
    objectName                    = [[cremfactory.s3o]],
    script                        = [[customFactory.lua]],
    selfDestructAs                = [[LARGE_BUILDINGEX]],
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
  
  return lowerkeys({factorylight = unitDef})
  