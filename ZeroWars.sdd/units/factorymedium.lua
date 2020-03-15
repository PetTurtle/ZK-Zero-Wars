unitDef = {
  unitname                      = [[factorymedium]],
  name                          = [[Medium Factory]],
  description                   = [[Builds at 10 m/s]],
  acceleration                  = 0,
  brakeRate                     = 1.5,
  buildCostMetal                = 400,
  buildDistance                 = 800,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 11,
  buildingGroundDecalSizeY      = 11,
  buildingGroundDecalType       = [[factoryveh_aoplane.dds]],

  buildoptions                  = {
    [[shieldscout]],
    [[hoverheavyraid]],
    [[spiderskirm]],
    [[vehriot]],
	  [[shieldarty]],
    [[shieldbomb]],
    [[amphaa]],
  },

  buildPic                      = [[factoryveh.png]],
  canGuard                      = true,
  canMove                       = false,
  canPatrol                     = true,
  cantBeTransported             = true,
  category                      = [[SINK UNARMED]],
  collisionVolumeOffsets        = [[0 0 -25]],
  collisionVolumeScales         = [[120 40 40]],
  collisionVolumeType           = [[box]],
  selectionVolumeOffsets        = [[0 0 10]],
  selectionVolumeScales         = [[120 70 112]],
  selectionVolumeType           = [[box]],
  corpse                        = [[DEAD]],

  customParams                  = {
      morphto = [[factorymediumadv]],
      morphcost = 800,
  },

  explodeAs                     = [[LARGE_BUILDINGEX]],
  floater                       = true,
  footprintX                    = 8,
  footprintZ                    = 8,
  iconType                      = [[facvehicle]],
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
  objectName                    = [[factoryveh.dae]],
  script                        = [[customFactory.lua]],
  selfDestructAs                = [[LARGE_BUILDINGEX]],
  showNanoSpray                 = true,
  sightDistance                 = 380,
  turnRate                      = 1,
  upright                       = true,
  useBuildingGroundDecal        = true,
  workerTime                    = 10,

  featureDefs                   = {

    DEAD  = {
      blocking         = false,
      featureDead      = [[HEAP]],
      footprintX       = 8,
      footprintZ       = 8,
      object           = [[factoryveh_d.dae]],
      collisionVolumeOffsets = [[0 0 -20]],
      collisionVolumeScales  = [[110 35 75]],
      collisionVolumeType    = [[box]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 7,
      footprintZ       = 7,
      object           = [[debris4x4c.s3o]],
    },

  },

}

return lowerkeys({factorymedium = unitDef})


