include("LuaRules/Configs/customcmds.h.lua")

local heavyTimeout = 7000 -- 3.88m
local normalTimeout = 5000 -- 2.77m 
local skirmTimeout = 4000 -- 2.22m
local artyTimeout = 4000 -- 2.22m
local antiairTimeout = 3600 -- 2.00m

local antiairUnits = {
    amphaa = true,
    gunshipaa = true,
    hoveraa = true,
    jumpaa = true,
    planeheavyfighter = true,
    shieldaa = true,
    shipaa = true,
    spideraa = true,
    tankaa = true,
    vehaa = true
}

Clones = {}
Clones.__index = Clones

function Clones:Create()
    local o = {}
    setmetatable(o, Clones)
    o.clones = {}
    o.idle = {}
    o.timeout = {
        normal = {},
        skirm = {},
        heavy = {},
        arty = {},
        antiAir = {}
    }
    return o
end

function Clones:NewClones(clones, originals, frame)
    assert(#clones == #originals)

    local normal = {units = {}, frame = frame}
    local skirm = {units = {}, frame = frame}
    local heavy = {units = {}, frame = frame}
    local arty = {units = {}, frame = frame}
    local antiAir = {units = {}, frame = frame}

    for i = 1, #clones do
        self.clones[clones[i]] = {clones = clones[i], originals = originals[i]}

        local unitDefID = Spring.GetUnitDefID(clones[i])
        local ud = UnitDefs[unitDefID]
        local range = ud.maxWeaponRange
        local mass = Spring.GetUnitMass(clones[i])

        if antiairUnits[ud.unitname] then
            antiAir.units[#antiAir.units + 1] = clones[i]
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
        self.timeout.normal[#self.timeout.normal + 1] = normal
    end
    if #skirm.units > 0 then
        self.timeout.skirm[#self.timeout.skirm + 1] = skirm
    end
    if #heavy.units > 0 then
        self.timeout.heavy[#self.timeout.heavy + 1] = heavy
    end
    if #arty.units > 0 then
        self.timeout.arty[#self.timeout.arty + 1] = arty
    end
    if #antiAir.units > 0 then
        self.timeout.antiAir[#self.timeout.antiAir + 1] = antiAir
    end
end

function Clones:ClearUnitType(unitType, timeout, frame)
    while #unitType > 0 and unitType[1].frame + timeout < frame do
        Spring.Echo("Clearing Started".. frame)
        local units = unitType[1].units
        for i = 1, #units do
            if not Spring.GetUnitIsDead(units[i]) then
                Spring.DestroyUnit(units[i], false, true)
            end
        end
        table.remove(unitType, 1)
    end
end

function Clones:ClearTimedOut(frame)
    self:ClearUnitType(self.timeout.heavy, heavyTimeout, frame)
    self:ClearUnitType(self.timeout.normal, normalTimeout, frame)
    self:ClearUnitType(self.timeout.skirm, skirmTimeout, frame)
    self:ClearUnitType(self.timeout.arty, artyTimeout, frame)
    self:ClearUnitType(self.timeout.antiAir, antiairTimeout, frame)
end

return Clones
