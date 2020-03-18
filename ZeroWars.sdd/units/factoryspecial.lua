unitDef = {
  unitname                      = [[factoryspecial]],
  name                          = [[Special Factory]],
  description                   = [[Builds at 10 m/s]],
  acceleration                  = 0,
  brakeRate                     = 1.5,
  buildCostMetal                = 400,
  buildDistance                 = 800,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 10,
  buildingGroundDecalSizeY      = 10,
  buildingGroundDecalType       = [[factoryspider_aoplane.dds]],

  buildoptions                  = {
    [[jumpscout]],
    [[amphraid]],
    [[jumpraid]],
    [[jumpblackhole]],
    [[jumpskirm]],
    [[jumpassault]],
    [[amphbomb]],
    [[jumpaa]],
  },

  buildPic                      = [[factoryspider.png]],
  canGuard                      = true,
  canMove                       = false,
  canPatrol                     = true,
  cantBeTransported             = true,
  category                      = [[SINK UNARMED]],
  collisionVolumeOffsets        = [[0 0 -16]],
  collisionVolumeScales         = [[104 50 36]],
  collisionVolumeType           = [[box]],
  selectionVolumeOffsets        = [[0 0 14]],
  selectionVolumeScales         = [[104 50 96]],
  selectionVolumeType           = [[box]],
  corpse                        = [[DEAD]],

  customParams                  = {
    morphto = [[factoryspecialadv]],
    morphcost = 800,
  },

  explodeAs                     = [[LARGE_BUILDINGEX]],
  floater                       = true,
  footprintX                    = 7,
  footprintZ                    = 7,
  iconType                      = [[facspider]],
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
  objectName                    = [[factory3.s3o]],
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
      footprintX       = 5,
      footprintZ       = 6,
      object           = [[factory3_dead.s3o]],
      collisionVolumeOffsets        = [[0 0 -16]],
      collisionVolumeScales         = [[104 50 36]],
      collisionVolumeType           = [[box]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 5,
      footprintZ       = 5,
      object           = [[debris4x4c.s3o]],
    },

  },

}
  
return lowerkeys({factoryspecial = unitDef})
  