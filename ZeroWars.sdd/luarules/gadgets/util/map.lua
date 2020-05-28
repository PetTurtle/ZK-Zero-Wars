local Map = {}
Map.__index = Map

function Map.new()
    local instance = {}
    setmetatable(instance, Map)
    return instance
end

function Map:getAllyTeams()
    local leftSide, rightSide
    local allyTeamList = Spring.GetAllyTeamList()
    local x, y = self:getAllyTeamSpawn(allyTeamList[1])
    local GaiaAllyID = select(6, Spring.GetTeamInfo(Spring.GetGaiaTeamID()))
    if x > 3000 then
        leftSide = allyTeamList[2] or GaiaAllyID
        rightSide = allyTeamList[1] or GaiaAllyID
    else
        leftSide = allyTeamList[1] or GaiaAllyID
        rightSide = allyTeamList[2] or GaiaAllyID
    end
    return leftSide, rightSide
end

-- get spawn position (x, z) of allyTeamID
function Map:getAllyTeamSpawn(allyTeamID)
    local teams = Spring.GetTeamList(allyTeamID)
    local boxID = Spring.GetTeamRulesParam(teams[1], "start_box_id")
    local startposList = GG.startBoxConfig[boxID] and GG.startBoxConfig[boxID].startpoints
    local startpos = startposList[1]
    return startpos[1], startpos[2]
end

return Map
