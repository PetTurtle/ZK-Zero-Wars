local Platform = {}
Platform.__index = Platform

function Platform.new(_rect, _buildings)
    local instance = {
        deployZone = _rect,
        buildings = _buildings,
        spawned = {},
        players = {}
    }
    setmetatable(instance, Platform)
    instance.deployZone:setBuildMaskOutline(0)
    return instance
end

function Platform:updateBuildings()
    if #self.players == 0 then
        if #self.spawned > 0 then
            for i = 1, #self.spawned do
                Spring.SetUnitNoDraw(self.spawned[i], true)
                Spring.SetUnitNoMinimap(self.spawned[i], true)
                Spring.DestroyUnit(self.spawned[i], false, true)
                self.spawned[i] = nil
            end
        end
    elseif #self.spawned == 0 then
        local x, z = self.deployZone:getTopLeft()
        for i = 1, #self.buildings do
            local building = self.buildings[i]
            self.spawned[i] = Spring.CreateUnit(building.unitName, building.x + x, 200, building.z + z, building.dir, 0)
        end
    end
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
        self:updateBuildings()
        return true
    end
    return false
end

function Platform:removePlayer(playerID)
    for i = 1, #self.players do
        if self.players[i] == playerID then
            table.remove(self.players, i)
            self:updateBuildings()
        end
    end
end

return Platform
