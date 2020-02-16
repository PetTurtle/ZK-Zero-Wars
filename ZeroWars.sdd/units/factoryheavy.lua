unitDef = {
  unitname         = [[factoryheavy]],
  name             = [[Heavy Platform]],
  description      = [[Builds at 10 m/s]],
  acceleration                  = 0,
  brakeRate                     = 1.5,
  buildCostMetal                = 400,
  buildDistance                 = 800,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 15,
  buildingGroundDecalSizeY      = 15,
  buildingGroundDecalType       = [[factoryhover_aoplane.dds]],

  buildoptions     = {
    [[vehriot]],
    [[vehassault]],
    [[hoverskirm]],
    [[tankheavyraid]],
    [[tankriot]],
    [[tankarty]],
    [[tankaa]],
  },

  buildPic         = [[factoryhover.png]],
  canGuard                      = true,
  canMove                       = false,
  canPatrol                     = true,
  cantBeTransported             = true,
  category         = [[UNARMED FLOAT]],
  collisionVolumeOffsets  = [[0 -2 0]],
  collisionVolumeScales   = [[124 32 124]],
  collisionVolumeType     = [[cylY]],
  selectionVolumeOffsets  = [[0 0 0]],
  selectionVolumeScales   = [[130 20 130]],
  selectionVolumeType     = [[box]],
  corpse           = [[DEAD]],

  customParams     = {
    morphto = [[factoryheavyadv]],
    morphcost = 800,
  },

  explodeAs        = [[LARGE_BUILDINGEX]],
  floater                       = true,
  footprintX       = 8,
  footprintZ       = 12,
  iconType         = [[fachover]],
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
  objectName       = [[factoryhover.s3o]],
  script           = [[customFactory.lua]],
  selfDestructAs   = [[LARGE_BUILDINGEX]],
  showNanoSpray                 = true,
  sightDistance                 = 380,
  turnRate                      = 1,
  upright                       = true,
  useBuildingGroundDecal        = true,
  workerTime                    = 10,

  featureDefs      = {

    DEAD  = {
      blocking         = false,
      featureDead      = [[HEAP]],
      footprintX       = 8,
      footprintZ       = 7,
      object           = [[factoryhover_dead.s3o]],
      collisionVolumeOffsets  = [[0 -2 -50]],
      collisionVolumeScales   = [[124 32 124]],
      collisionVolumeType     = [[cylY]],

    },


    HEAP  = {
      blocking         = false,
      footprintX       = 8,
      footprintZ       = 7,
      object           = [[debris4x4c.s3o]],
    },

  },

}

return lowerkeys({factoryheavy = unitDef})