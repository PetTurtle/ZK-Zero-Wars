local Map = {}
Map.__index = Map

function Map.new()
    local instance = {}
    setmetatable(instance, Map)
    return instance
end

function Map:replaceStartUnit(unitName)
    local replaceRadius = 64
    local replacements = {}
    for teamID, spawn in pairs(GG.CommanderSpawnLocation) do
        local unitSizeX = UnitDefNames[unitName].xsize
        local unitSizeZ = UnitDefNames[unitName].zsize
        local x = math.max(unitSizeX, math.min(Game.mapSizeX - unitSizeX, spawn.x))
        local z = math.max(unitSizeZ, math.min(Game.mapSizeZ - unitSizeZ, spawn.z))
        local y = Spring.GetGroundHeight(x, z)
        local nearbyUnits = Spring.GetUnitsInCylinder(spawn.x, spawn.z, replaceRadius, teamID)
        local unitID = Spring.CreateUnit(unitName, x, y, z, spawn.facing, teamID)
        table.insert(replacements, unitID)
        if nearbyUnits and #nearbyUnits then
            for _, unitID in pairs(nearbyUnits) do
                Spring.DestroyUnit(unitID, false, true)
            end
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

function Map:getAllyStart(allyTeam)
	local teamList = Spring.GetTeamList(allyTeam)
	if teamList and #teamList > 0 then
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