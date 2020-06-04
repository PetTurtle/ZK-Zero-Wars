local Platform = {}
Platform.__index = Platform

function Platform.new(_rect)
    local instance = {
        deployZone = _rect,
        players = {}
    }
    setmetatable(instance, Platform)
    instance.deployZone:setBuildMaskOutline(0)
    return instance
end


function Platform:hasPlayer(playerID)
    for i = 1, #self.players do
        if self.players[i] == playerID then
            return true
        end
    end
    return false
end

function Platform:addPlayer(playerID, x, z)
    if self.deployZone:hasPoint(x, z) then
        table.insert(self.players, playerID)
        return true
    end
    return false
end

function Platform:removePlayer(playerID)
    for i = 1, #self.players do
        if self.players[i] == playerID then
            table.remove(self.players, i)
        end
    end
end

return Platform
