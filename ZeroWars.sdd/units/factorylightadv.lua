unitDef = {
    unitname                      = [[factorylightadv]],
    name                          = [[Light Factory Advanced]],
    description                   = [[Builds at 10 m/s]],
    acceleration                  = 0,
    brakeRate                     = 1.5,
    buildCostMetal                = Shared.FACTORY_COST,
    buildDistance                 = 600,
    builder                       = true,
    buildingGroundDecalDecaySpeed = 30,
    buildingGroundDecalSizeX      = 12,
    buildingGroundDecalSizeY      = 12,
    buildingGroundDecalType       = [[factoryshield_aoplane.dds]],
  
    buildoptions                  = {
      [[cloakheavyraid]],
      [[vehsupport]],
      [[cloakriot]],
      [[spiderassault]],
      [[cloakarty]],
      [[zwimp]],
      [[cloakaa]],
      [[cloakassault]],
      [[cloakjammer]],
      [[grebe]],
      [[striderscorpion]],
      [[cloaksnipe]],
      [[striderantiheavy]],
    },
  
    buildPic                      = [[factoryshield.png]],
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
  
    explodeAs                     = [[LARGE_BUILDINGEX]],
    floater                       = true,
    footprintX                    = 6,
    footprintZ                    = 9,
    iconType                      = [[facwalker]],
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
    objectName                    = [[factory.s3o]],
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
        footprintX       = 5,
        footprintZ       = 6,
        object           = [[factory_dead.s3o]],
      },
  
  
      HEAP = {
        blocking         = false,
        footprintX       = 5,
        footprintZ       = 5,
        object           = [[debris4x4a.s3o]],
      },
  
    },
  
  }
  
  return lowerkeys({factorylightadv = unitDef})
  