local function getAllyTeamSpawn(allyTeamID)
    local teamList = Spring.GetTeamList(allyTeamID)
    if teamList and #teamList then
        local boxID = Spring.GetTeamRulesParam(teamList[1], "start_box_id")
        if boxID then
            local startName = GG.startBoxConfig[boxID].nameShort
            return startName
        end
    end
end

local function getAllyStarts()
    local allyTeamList = Spring.GetAllyTeamList()
    local mapStarts = {}

    for allyTeam in pairs(allyTeamList) do
        local startName = getAllyTeamSpawn(allyTeam)
        if startName then
            mapStarts[startName] = allyTeam
        end
    end

    return mapStarts
end

return getAllyStarts

