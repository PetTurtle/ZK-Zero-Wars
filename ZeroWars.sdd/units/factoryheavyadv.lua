unitDef = {
  unitname                      = [[factoryheavyadv]],
  name                          = [[Advanced Heavy Factory]],
  description                   = [[Produces Heavy Tracked Vehicles, Builds at 10 m/s]],
  acceleration                  = 0,
  brakeRate                     = 1.5,
  buildCostMetal                = 800,
  buildDistance                 = 800,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 11,
  buildingGroundDecalSizeY      = 11,
  buildingGroundDecalType       = [[factorytank_aoplane.dds]],

  buildoptions                  = {
    [[vehriot]],
    [[vehassault]],
    [[hoverskirm]],
    [[tankheavyraid]],
    [[tankriot]],
    [[tankarty]],
    [[tankaa]],
    [[vehcapture]],
    [[amphfloater]],
    [[tankassault]],
    [[tankheavyassault]],
    [[striderdetriment]],
  },

  buildPic                      = [[factorytank.png]],
  canGuard                      = true,
  canMove                       = false,
  canPatrol                     = true,
  cantBeTransported             = true,
  category                      = [[SINK UNARMED]],
  corpse                        = [[DEAD]],
  collisionVolumeOffsets        = [[0 0 -25]],
  collisionVolumeScales         = [[110 28 44]],
  collisionVolumeType           = [[box]],
  selectionVolumeOffsets        = [[0 0 10]],
  selectionVolumeScales         = [[120 28 120]],
  selectionVolumeType           = [[box]],

  customParams                  = {
  },

  explodeAs                     = [[LARGE_BUILDINGEX]],
  floater                       = true,
  footprintX                    = 8,
  footprintZ                    = 8,
  iconType                      = [[factank]],
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
  objectName                    = [[factorytank.s3o]],
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
      footprintX       = 8,
      footprintZ       = 8,
      object           = [[factorytank_dead.s3o]],
      collisionVolumeOffsets = [[0 14 -34]],
      collisionVolumeScales  = [[110 28 44]],
      collisionVolumeType    = [[box]],
    },


    HEAP = {
      blocking         = false,
      footprintX       = 6,
      footprintZ       = 6,
      object           = [[debris4x4a.s3o]],
    },

  },

}
  
return lowerkeys({factoryheavyadv = unitDef})