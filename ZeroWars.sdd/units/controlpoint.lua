unitDef = {
    maxDamage = 800,
    unitname = [[controlpoint]],
    name = [[Control Point]],
    description = [[Provides Metal When Claimed]],
    objectName = [[pw_artefact.dae]],
    script = [[controlpoint.lua]],
    iconType = [[pw_special]],
    buildPic = [[pw_artefact.png]],
    footprintX = 4,
    footprintZ = 4,
    buildCostMetal = 600,
    customParams = {
        soundselect = [[cloaker_select]],
        collisionvolumescales = [[60 70 60]],
        collisionvolumetype = [[CylY]]
    },
    featureDefs = {
        DEAD = {
            blocking = false,
            featureDead = [[HEAP]],
            footprintX = 4,
            footprintZ = 4,
            object = [[pw_artefact_dead.dae]]
        }
    }
}

return lowerkeys({controlpoint = unitDef})
