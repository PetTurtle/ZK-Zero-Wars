local Map = {}
Map.__index = Map

function Map.new()
    local instance = {}
    setmetatable(instance, Map)
    return instance
end

function Map:replaceStartUnit(unitName)
    local replacements = {}
    for teamID, spawn in pairs(GG.CommanderSpawnLocation) do
        local unitID = Spring.CreateUnit(unitName, spawn.x, spawn.y, spawn.z, spawn.facing, teamID)
        Spring.SetUnitRulesParam(unitID, "facplop", 1, {inlos = true})
        table.insert(replacements, unitID)
        local nearbyUnits = Spring.GetUnitsInCylinder(spawn.x, spawn.z, 50, teamID)
        if nearbyUnits and #nearbyUnits then
            Spring.DestroyUnit(nearbyUnits[1], false, true)
        end
    end
    return replacements
end

function Map:setMetalStorage(amount)
    for i, allyTeam in pairs(Spring.GetAllyTeamList()) do
        for j, team in pairs(Spring.GetTeamList(allyTeam)) do
            Spring.SetTeamResource(team, "metal", amount)
        end
    end
end

function Map:getAllyStart(allyTeamID)
    local teamList = Spring.GetTeamList(allyTeamID)
    if teamList and #teamList then
        local boxID = Spring.GetTeamRulesParam(teamList[1], "start_box_id")
        if boxID then
            local startName = GG.startBoxConfig[boxID].nameShort
            return startName
        end
    end
end

function Map:getAllyStarts()
    local allyTeamList = Spring.GetAllyTeamList()
    local mapStarts = {}

    for allyTeam in pairs(allyTeamList) do
        local startName = self:getAllyStart(allyTeam)
        if startName then
            mapStarts[startName] = allyTeam
        end
    end

    return mapStarts
end

return Map