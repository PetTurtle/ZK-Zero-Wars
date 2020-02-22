unitDef = {
  unitname                      = [[factoryjump]],
  name                          = [[Advanced Special Factory]],
  description                   = [[Produces Jumpjet Equipped Robots, Builds at 10 m/s]],
  acceleration                  = 0,
  brakeRate                     = 1.5,
  buildCostMetal                = 800,
  buildDistance                 = 800,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 10,
  buildingGroundDecalSizeY      = 10,
  buildingGroundDecalType       = [[factoryjump_aoplane.dds]],

  buildoptions                  = {
    [[jumpscout]],
    [[amphraid]],
    [[jumpraid]],
    [[jumpblackhole]],
    [[jumpskirm]],
    [[jumpassault]],
    [[zwlimpet]],
    [[jumpaa]],
    [[zwhalberd]],
    [[hoverriot]],
    [[spidercrabe]],
    [[jumpsumo]],
    [[zwskuttle]],
    [[striderbantha]],
  },

  buildPic                      = [[factoryjump.png]],
  canGuard                      = true,
  canMove                       = false,
  canPatrol                     = true,
  cantBeTransported             = true,
  category                      = [[SINK UNARMED]],
  collisionVolumeOffsets        = [[0 0 -18]],
  collisionVolumeScales         = [[104 70 40]],
  collisionVolumeType           = [[box]],
  selectionVolumeOffsets        = [[0 0 12]],
  selectionVolumeScales         = [[104 70 100]],
  selectionVolumeType           = [[box]],
  corpse                        = [[DEAD]],

  customParams                  = {
  },

  explodeAs                     = [[LARGE_BUILDINGEX]],
  floater                       = true,
  footprintX                    = 7,
  footprintZ                    = 7,
  iconType                      = [[facjumpjet]],
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
  objectName                    = [[factoryjump.s3o]],
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
      object           = [[factoryjump_dead.s3o]],
      collisionVolumeOffsets        = [[0 0 -18]],
      collisionVolumeScales         = [[104 70 40]],
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
  
return lowerkeys({factoryspecialadv = unitDef})