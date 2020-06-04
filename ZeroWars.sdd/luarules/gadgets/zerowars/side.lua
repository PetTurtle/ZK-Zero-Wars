local Platform = VFS.Include("luarules/gadgets/zerowars/platform.lua")

local Side = {}
Side.__index = Side

function Side.new(_allyTeamID, _centerBuildings, _rects)
    local instance = {
        allyTeamID = _allyTeamID or 0,
        teams = Spring.GetTeamList(_allyTeamID),
        platforms = {
            Platform.new(_rects[1]),
            Platform.new(_rects[2]),
            Platform.new(_rects[3])
        }
    }
    setmetatable(instance, Side)

    for i, building in pairs(_centerBuildings) do
        Spring.CreateUnit(building.unitName, building.x, 128, building.z, building.dir, instance.teams[1])
    end

    return instance
end

function Side:updatePlayerSpawn(playerID, x, z)
    for i = 1, #self.platforms do
        local platform = self.platforms[i]
        if platform:hasPlayer(playerID) then
            platform:removePlayer(playerID)
        end

        platform:addPlayer(playerID, x, z)
    end
end

return Side
