unitDef = {
    maxDamage = 800,
    unitname = [[mextier1]],
    name = [[Metal Extractor Tier 1]],
    description = [[Produces Metal]],
    iconType = [[mex]],
    buildPic = [[staticmex.png]],
    objectName = [[AMETALEXTRACTORLVL1.S3O]],
    script = [[mextier1.lua]],
    buildCostMetal = 200,
    metalMake = 1,
    footprintX = 6,
    footprintZ = 6,
    customParams = {
        morphto = [[mextier2]],
        morphcost = 500,
    },
    featureDefs = {
        DEAD = {
            blocking = false,
            featureDead = [[HEAP]],
            footprintX = 6,
            footprintZ = 6,
            object = [[AMETALEXTRACTORLVL1_DEAD.s3o]]
        }
    }
}
return lowerkeys({mextier1 = unitDef})
