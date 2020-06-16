local Queue = VFS.Include("luarules/gadgets/util/queue.lua")
local spawnAmount = 12
local mapCenter = Game.mapSizeX / 2

local Deployer = {}
Deployer.__index = Deployer

function Deployer.new()
    local instance = {
        spawnQueue = Queue.new(),
    }
    setmetatable(instance, Deployer)
    return instance
end

function Deployer:add(rect, targetRect, teamID, faceDir, attackX)
    local xmin, zmin = rect:getTopLeft()
    local xmax, zmax = rect:getBottomRight()
    local units = Spring.GetUnitsInRectangle(xmin, zmin, xmax, zmax, teamID)
    local unit, ud, buildProgress
    local validUnits = {}
    for i = 1, #units do
        unit = units[i]
        ud = UnitDefs[Spring.GetUnitDefID(unit)]
        buildProgress = select(5, Spring.GetUnitHealth(unit))
        if buildProgress >= 1.0 and not (ud.isBuilding or ud.isBuilder) then
            validUnits[#validUnits + 1] = unit
        end
    end
    if #validUnits > 0 then
        local offset = rect:getOffset(targetRect)
        self.spawnQueue:push({units = validUnits, offset = offset, teamID = teamID, faceDir = faceDir, attackX = attackX})
    end
end

function Deployer:deploy()
    if self.spawnQueue:size() == 0 then
        return
    end

    local group = self.spawnQueue:peek()
    local units = group.units
    local offset = group.offset
    local clone, x, y, z
    for i = #units, math.max(1, #units - spawnAmount), -1 do
        if not Spring.GetUnitIsDead(units[i]) then
            x, y, z = Spring.GetUnitPosition(units[i])
            if x then
                clone = GG.cloneUnit(units[i], x + offset.x, 300, z + offset.z, group.faceDir, group.teamID)

                Spring.SetUnitRulesParam(clone, "clone", 1)
                Spring.SetUnitRulesParam(clone, "original", units[i])
                Spring.GiveOrderToUnit(
                    clone,
                    CMD.INSERT,
                    {-1, CMD.FIGHT, CMD.OPT_SHIFT, mapCenter, 128, z + offset.z},
                    {"alt"}
                )
                Spring.GiveOrderToUnit(
                    clone,
                    CMD.INSERT,
                    {-1, CMD.FIGHT, CMD.OPT_SHIFT, group.attackX, 128, z + offset.z},
                    {"alt"}
                )
                units[i] = nil
            end
        end
    end
    if #units == 0 then
        self.spawnQueue:pop()
    end
end

return Deployer