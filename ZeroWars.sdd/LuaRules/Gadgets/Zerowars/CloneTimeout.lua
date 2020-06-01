local Queue = VFS.Include("LuaRules/Gadgets/Data/Queue.lua")

local spDestroyUnit = Spring.DestroyUnit

local spGetUnitDefID = Spring.GetUnitDefID
local spGetUnitMass = Spring.GetUnitMass
local spGetUnitIsDead = Spring.GetUnitIsDead

local normalTimeout = 5000 -- 2.77m
local skirmTimeout = 4000 -- 2.22m
local heavyTimeout = 7000 -- 3.88m
local artyTimeout = 4000 -- 2.22m
local antiairTimeout = 1800 -- 1.00m

local CloneTimeout = {}
CloneTimeout.__index = CloneTimeout

function CloneTimeout.new()
    local instance = {
        _normal = Queue.new(),
        _skirm = Queue.new(),
        _heavy = Queue.new(),
        _arty = Queue.new(),
        _antiAir = Queue.new()
    }
    setmetatable(instance, CloneTimeout)
    return instance
end

function CloneTimeout:add(clones, frame)
    local normal = {units = {}, frame = frame}
    local skirm = {units = {}, frame = frame}
    local heavy = {units = {}, frame = frame}
    local arty = {units = {}, frame = frame}
    local antiAir = {units = {}, frame = frame}

    for i = 1, #clones do
        local ud = UnitDefs[spGetUnitDefID(clones[i])]
        local range = ud.maxWeaponRange
        local mass = spGetUnitMass(clones[i])

        if ud.weapons[1] and not ud.weapons[1].onlyTargets.land then
            antiAir.units[#antiAir.units + 1] = clones[i]
        elseif ud.canFly then
            heavy.units[#heavy.units + 1] = clones[i]
        elseif mass > 1000 then
            heavy.units[#heavy.units + 1] = clones[i]
        elseif range >= 600 then
            arty.units[#arty.units + 1] = clones[i]
        elseif mass > 252 then
            heavy.units[#heavy.units + 1] = clones[i]
        elseif range >= 455 then
            skirm.units[#skirm.units + 1] = clones[i]
        else
            normal.units[#normal.units + 1] = clones[i]
        end
    end

    if #normal.units > 0 then
        self._normal:push(normal)
    end
    if #skirm.units > 0 then
        self._skirm:push(skirm)
    end
    if #heavy.units > 0 then
        self._heavy:push(heavy)
    end
    if #arty.units > 0 then
        self._arty:push(arty)
    end
    if #antiAir.units > 0 then
        self._antiAir:push(antiAir)
    end
end

function CloneTimeout:clear(frame)
    self:clearUnitType(self._heavy, heavyTimeout, frame)
    self:clearUnitType(self._normal, normalTimeout, frame)
    self:clearUnitType(self._skirm, skirmTimeout, frame)
    self:clearUnitType(self._arty, artyTimeout, frame)
    self:clearUnitType(self._antiAir, antiairTimeout, frame)
end

------------------------------
-- Private Functions
------------------------------

function CloneTimeout:clearUnitType(typeQueue, timeout, frame)
    while typeQueue:size() > 0 and typeQueue:peek().frame + timeout < frame do
        local units = typeQueue:pop().units
        for i = 1, #units do
            if not spGetUnitIsDead(units[i]) then
                spDestroyUnit(units[i], false, true)
            end
        end
    end
end

return CloneTimeout
