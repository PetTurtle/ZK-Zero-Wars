unitDef = {
    maxDamage = 800,
    unitname = [[mextier4]],
    name = [[Metal Extractor Tier 4]],
    description = [[Produces Metal]],
    iconType = [[mex]],
    buildPic = [[pw_gaspowerstation.png]],
    objectName = [[pw_gaspowerstation.dae]],
    script = [[mextier4.lua]],
    buildCostMetal = 200,
    metalMake = 12,
    footprintX = 6,
    footprintZ = 6,
    customParams = {},
    featureDefs = {
        DEAD = {
            blocking = false,
            featureDead = [[HEAP]],
            footprintX = 6,
            footprintZ = 6,
            object = [[pw_gaspowerstation_dead.dae]]
        }
    }
}
return lowerkeys({mextier4 = unitDef})
