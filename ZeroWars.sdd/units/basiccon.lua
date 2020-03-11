unitDef = {
  unitname            = [[basiccon]],
  name                = [[Basic Con]],
  description         = [[Basic Bot, Builds at 10 m/s]],
  acceleration        = 1.2,
  activateWhenBuilt   = true,
  brakeRate           = 1.5,
  buildCostMetal      = 150,
  buildDistance       = 500,
  builder             = true,

  buildoptions        = {
    [[staticmex]],
    [[energysolar]],
    [[energyfusion]],
    [[energysingu]],
    [[energypylon]],
    
    [[cloakraid]],
    [[spiderassault]],
    [[cloakskirm]],
    [[spideremp]],
    [[veharty]],
    [[zwgull]],

    [[tankraid]],
    [[spiderriot]],
    [[amphimpulse]],
    [[basiccon]],
    
    [[factoryair]],
    [[factorylight]],
    [[factorymedium]],
    [[factoryheavy]],
    [[factoryspecial]],
  },

  buildPic            = [[amphcon.png]],
  canMove             = true,
  canPatrol           = true,
  category            = [[LAND UNARMED]],
  corpse              = [[DEAD]],

  customParams        = {
    amph_regen = 10,
    amph_submerged_at = 40,
  },

  explodeAs           = [[BIG_UNITEX]],
  energyStorage       = 1000,
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[builder]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maxDamage           = 850,
  maxSlope            = 36,
  maxVelocity         = 1.7,
  metalStorage        = 1000,
  minCloakDistance    = 75,
  movementClass       = [[AKBOT2]],
  objectName          = [[amphcon.s3o]],
  selfDestructAs      = [[BIG_UNITEX]],
  script              = [[customcon.lua]],
  showNanoSpray       = false,
  sightDistance       = 375,
  sonarDistance       = 375,
  trackOffset         = 0,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ChickenTrackPointy]],
  trackWidth          = 22,
  turnRate            = 1000,
  upright             = false,
  workerTime          = 10,

  featureDefs         = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[amphcon_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2a.s3o]],
    },

  },

}

return lowerkeys({basiccon = unitDef})