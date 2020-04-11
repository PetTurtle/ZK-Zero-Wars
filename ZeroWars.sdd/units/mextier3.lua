unitDef = {
    maxDamage = 800,
    unitname = [[mextier3]],
    name = [[Metal Extractor Tier 3]],
    description = [[Produces Metal]],
    iconType = [[mex]],
    buildPic = [[pw_estorage2.png]],
    objectName = [[pw_estorage2.dae]],
    script = [[mextier3.lua]],
    buildCostMetal = 800,
    metalMake = 6,
    footprintX = 6,
    footprintZ = 6,
    reclaimable = false,
    canSelfD = false,
    capturable = false,
    customParams = {
        morphto = [[mextier4]],
        morphcost = 900
    },
    featureDefs = {
        DEAD = {
            blocking = false,
            featureDead = [[HEAP]],
            footprintX = 6,
            footprintZ = 6,
            object = [[pw_estorage2_dead.dae]]
        }
    }
}
return lowerkeys({mextier3 = unitDef})
