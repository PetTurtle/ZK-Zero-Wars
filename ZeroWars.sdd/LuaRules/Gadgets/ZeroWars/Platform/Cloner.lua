include("LuaRules/Configs/customcmds.h.lua")

Cloner = {}
Cloner.__index = Cloner

function Cloner:Create(deployRect, faceDir)
    local o = {}
    setmetatable(o, Cloner)
    o.deployRect = deployRect
    o.faceDir = faceDir
    o.queue = {}
    o.spawnAmount = 12
    return o
end

function Cloner:Add(platform)
    local units = platform:GetUnits()
    if not units then return end
    
    while(#units > 0) do
        local deployGroup = {
            units = self:MoveList(units, 1, math.min(self.spawnAmount, #units)),
            platform = platform
        }
        self.queue[#self.queue + 1] = deployGroup
    end
end

function Cloner:Deploy()
    local deployGroup = table.remove(self.queue, 1)

    local clones = {}
    local units = deployGroup.units
    local platform = deployGroup.platform
    local offset = platform.rect:GetPosOffset(self.deployRect)
    local teamID = Spring.GetUnitTeam(units[1])
        
    for i = 1, #units do
        local unitDefID = Spring.GetUnitDefID(units[i])
        local x, y, z = Spring.GetUnitPosition(units[i])  
        local clone = Spring.CreateUnit(unitDefID, x + offset.x, 150, z + offset.y, self.faceDir, teamID)
        clones[i] = clone
    end

    return clones, units
end

function Cloner:Size()
    return #self.queue
end

function Cloner:MoveList(list, from, to)
    local subset = {}
    local iterator = 1
    for i = to, from, -1 do
        subset[iterator] = list[i]
        iterator = iterator + 1
        table.remove(list, i)
    end
    return subset
end

return Cloner
