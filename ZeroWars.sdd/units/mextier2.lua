unitDef = {
    maxDamage = 800,
    unitname = [[mextier2]],
    name = [[Metal Extractor Tier 2]],
    description = [[Produces Metal]],
    iconType = [[mex]],
    buildPic = [[pw_estorage.png]],
    objectName = [[pw_estorage.dae]],
    script = [[mextier2.lua]],
    buildCostMetal = 500,
    metalMake = 3,
    footprintX = 6,
    footprintZ = 6,
    customParams = {
        morphto = [[mextier3]],
        morphcost = 800,
    },
    featureDefs = {
        DEAD = {
            blocking = false,
            featureDead = [[HEAP]],
            footprintX = 6,
            footprintZ = 6,
            object = [[pw_estorage_dead.dae]]
        }
    }
}
return lowerkeys({mextier2 = unitDef})
