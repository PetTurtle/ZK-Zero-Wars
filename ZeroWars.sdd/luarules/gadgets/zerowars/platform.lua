local Platform = {}
Platform.__index = Platform

function Platform.new(_rect)
    local instance = {
        deployZone = _rect,
        builders = {}
    }
    setmetatable(instance, Platform)
    instance.deployZone:setBuildMaskOutline(0)
    return instance
end

function Platform:addBuilder(builderID)
    table.insert(self.builders, builderID)
end

function Platform:hasActiveBuilder()
    -- probably a better way to do this, but #self.builders is always 0
    for _ in pairs(self.builders) do 
        return true
    end
    return false
end


return Platform
