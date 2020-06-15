local Platform = VFS.Include("luarules/gadgets/zerowars/platform.lua")

local Side = {}
Side.__index = Side

function Side.new(_allyTeamID, _platformRects, _deployRect, _buildings) 
    local instance = {
        allyTeamID = _allyTeamID or 0,
        teams = Spring.GetTeamList(_allyTeamID),
        deployRect = _deployRect,
        platforms = {
            Platform.new(_platformRects[1]),
            Platform.new(_platformRects[2]),
            Platform.new(_platformRects[3])
        },
        iterator = 0
    }
    setmetatable(instance, Side)

    for i, building in pairs(_buildings) do
        local unitID = Spring.CreateUnit(building.unitName, building.x, 128, building.z, building.dir, instance.teams[1])
        Spring.SetUnitNoSelect(unitID, building.noSelectable or false)
        Spring.SetUnitNeutral(unitID, building.neutral or false)
    end

    return instance
end

function Side:addBuilder(builderID)
    local x, y, z = Spring.GetUnitPosition(builderID)
    for _, platform in pairs(self.platforms) do
        if platform.deployZone:hasPoint(x, z) then
            platform:addBuilder(builderID)
            return
        end
    end
end

function Side:removedUnusedPlatforms()
    local remaining = {}
    for _, platform in pairs(self.platforms) do
        if platform:hasActiveBuilder() then
            remaining[#remaining + 1] = platform
        end
    end
    self.platforms = remaining
end

function Side:nextPlatform()
    self.iterator = ((self.iterator + 1) % #self.platforms)
    return self.platforms[self.iterator + 1]
end

function Side:hasPlatforms()
    return #self.platforms > 0
end

return Side
