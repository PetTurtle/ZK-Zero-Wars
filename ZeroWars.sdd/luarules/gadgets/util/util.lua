return {
    ReplaceStartUnit = function (unitName)
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
    end,

    MergeTeams = function (teamID, TargetTeamID)
        local playerList = Spring.GetPlayerList(teamID)
        for i = 1, #playerList do
            Spring.AssignPlayerToTeam(playerList[i], TargetTeamID)
        end
    end,

    SetGlobalMetalStorage = function (amount)
        for i, allyTeam in pairs(Spring.GetAllyTeamList()) do
            for j, team in pairs(Spring.GetTeamList(allyTeam)) do
                Spring.SetTeamResource(team, "metal", amount)
            end
        end
    end,

    SetBuildMask = function (x, z, width, height, mask)
        x = math.floor(x / 16)
        z = math.floor(z / 16)
        width = math.floor(width / 16)
        height = math.floor(height / 16)

        for _x = x, x + width do
            for _z = z, z + height do
                Spring.SetSquareBuildingMask(_x, _z, mask)
            end
        end
    end,

    SetBuildMaskOutline = function (x, z, width, height, mask)
        x = math.floor(x / 16)
        z = math.floor(z / 16)
        width = math.floor(width / 16)
        height = math.floor(height / 16)

        for _x = x, x + width do
            Spring.SetSquareBuildingMask(_x, z - 1, mask)
        end
        for _x = x, x + width do
            Spring.SetSquareBuildingMask(_x, z + height + 1, mask)
        end
        for _z = z, z + height do
            Spring.SetSquareBuildingMask(x - 1, _z, mask)
        end
        for _z = z, z + height do
            Spring.SetSquareBuildingMask(x + width + 1, _z, mask)
        end
    
        Spring.SetSquareBuildingMask(x - 1, z - 1, mask)
        Spring.SetSquareBuildingMask(x + width + 1, z - 1, mask)
        Spring.SetSquareBuildingMask(x - 1, z + height + 1, mask)
        Spring.SetSquareBuildingMask(x + width + 1, z + height + 1, mask)
    end,

    GetAllyStarts = function ()
        local AllyStarts = {}
        local allyTeams = Spring.GetAllyTeamList()

        for allyTeam in pairs(allyTeams) do
            local teams = Spring.GetTeamList(allyTeam)
            if teams and #teams > 0 then
                local boxID = Spring.GetTeamRulesParam(teams[1], "start_box_id")
                if boxID then
                    local startName = GG.startBoxConfig[boxID].nameShort
                    if startName then
                        AllyStarts[startName] = allyTeam
                    end
                end
            end
        end
        
        return AllyStarts
    end,

    HasRectPoint = function (x, y, width, height, pointX, pointY)
        return pointX > x and pointX < x + width and pointY > y and pointY < y + height
    end
}