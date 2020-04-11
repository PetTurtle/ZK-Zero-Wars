local Queue = VFS.Include("LuaRules/Gadgets/Data/Queue.lua")
local StateCopier = VFS.Include("LuaRules/Gadgets/Zerowars/StateCopier.lua")

local spGetUnitHealth = Spring.GetUnitHealth
local spGetUnitIsDead = Spring.GetUnitIsDead
local spGetUnitDefID = Spring.GetUnitDefID
local spGetUnitPosition = Spring.GetUnitPosition

local spCreateUnit = Spring.CreateUnit
local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spSetUnitRulesParam = Spring.SetUnitRulesParam

local Deployer = {}
Deployer.__index = Deployer

local mapCenter = Game.mapSizeX / 2

function Deployer.new()
    local instance = {
        _spawnQueue = Queue.new(),
        _stateCopier = StateCopier.new(),
        _spawnAmount = 12
    }
    setmetatable(instance, Deployer)
    return instance
end

function Deployer:add(platformUnits, offset, faceDir, attackXPos)
    for i = 1, #platformUnits do
        local units = platformUnits[i].units
        local ud
        local buildProgress
        for j = #units, 1, -1 do
            ud = UnitDefs[spGetUnitDefID(units[j])]
            buildProgress = select(5, spGetUnitHealth(units[j]))
            if buildProgress < 1.0 or (ud.isBuilding or ud.isBuilder) then
                table.remove(units, j)
            end
        end

        if #units > 0 then
            self:addTeamUnitsToQueue(platformUnits[i], offset, faceDir, attackXPos)
        end
    end
end

function Deployer:deploy()
    local group = self._spawnQueue:pop()
    local units = group.units
    local offset = group.offset
    local clones = {}
    local cloneCount = 1

    local unitDefID
    local ud
    local x, y, z
    local clone

    for i = 1, #units do
        if not spGetUnitIsDead(units[i]) then
            unitDefID = spGetUnitDefID(units[i])
            ud = UnitDefs[unitDefID]
            x, y, z = spGetUnitPosition(units[i])
            if x then
                if ud.canFly then
                    y = 200
                else
                    y = 128
                end

                clone = spCreateUnit(unitDefID, x + offset.x, y, z + offset.z, group.faceDir, group.teamID)
                self._stateCopier:copyUnitStates(units[i], clone)

                spSetUnitRulesParam(clone, "clone", 1)
                spSetUnitRulesParam(clone, "original", units[i])
                spGiveOrderToUnit(
                    clone,
                    CMD.INSERT,
                    {-1, CMD.FIGHT, CMD.OPT_SHIFT, mapCenter, 128, z + offset.z},
                    {"alt"}
                )
                spGiveOrderToUnit(
                    clone,
                    CMD.INSERT,
                    {-1, CMD.FIGHT, CMD.OPT_SHIFT, group.attackXPos, 128, z + offset.z},
                    {"alt"}
                )

                clones[cloneCount] = clone
                cloneCount = cloneCount + 1
            end
        end
    end
    return clones
end

function Deployer:size()
    return self._spawnQueue:size()
end

------------------------------
-- Private Functions
------------------------------

function Deployer:addTeamUnitsToQueue(platformUnits, offset, faceDir, attackXPos)
    local units = platformUnits.units

    while (#units > 0) do
        self._spawnQueue:push(
            {
                units = self:subsetUnits(units, 1, math.min(self._spawnAmount, #units)),
                teamID = platformUnits.team,
                offset = offset,
                faceDir = faceDir,
                attackXPos = attackXPos
            }
        )
    end
end

function Deployer:subsetUnits(units, from, to)
    local subset = {}
    local iterator = 1
    for i = to, from, -1 do
        subset[iterator] = units[i]
        iterator = iterator + 1
        table.remove(units, i)
    end
    return subset
end

return Deployer
