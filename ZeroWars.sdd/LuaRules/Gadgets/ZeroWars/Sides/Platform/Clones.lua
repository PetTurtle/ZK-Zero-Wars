include("LuaRules/Configs/customcmds.h.lua")
local Queue = VFS.Include("LuaRules/Gadgets/ZeroWars/Data/Queue.lua")

local heavyTimeout = 7000 -- 3.88m
local normalTimeout = 5000 -- 2.77m
local skirmTimeout = 4000 -- 2.22m
local artyTimeout = 4000 -- 2.22m
local antiairTimeout = 1800 -- 1.00m

Clones = {}
Clones.__index = Clones

function Clones:Create(side)
    local o = {}
    setmetatable(o, Clones)
    o.side = side
    o.idle = Queue:New()
    o.timeout = {
        normal = Queue:New(),
        skirm = Queue:New(),
        heavy = Queue:New(),
        arty = Queue:New(),
        antiAir = Queue:New()
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
        Spring.SetUnitRulesParam(clones[i], "clone", 1)
        Spring.SetUnitRulesParam(clones[i], "original", originals[i])
        Spring.SetUnitRulesParam(clones[i], "side", self.side)

        local unitDefID = Spring.GetUnitDefID(clones[i])
        local ud = UnitDefs[unitDefID]
        local range = ud.maxWeaponRange
        local mass = Spring.GetUnitMass(clones[i])

        if ud.weapons[1] and not ud.weapons[1].onlyTargets.land then
            antiAir.units[#antiAir.units + 1] = clones[i]
        elseif ud.canFly then
            normal.units[#normal.units + 1] = clones[i]
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
        self.timeout.normal:PushLeft(normal)
    end
    if #skirm.units > 0 then
        self.timeout.skirm:PushLeft(skirm)
    end
    if #heavy.units > 0 then
        self.timeout.heavy:PushLeft(heavy)
    end
    if #arty.units > 0 then
        self.timeout.arty:PushLeft(arty)
    end
    if #antiAir.units > 0 then
        self.timeout.antiAir:PushLeft(antiAir)
    end
end

function Clones:IsActiveClone(unitID)
    if not Spring.GetUnitIsDead(original) and Spring.GetUnitRulesParam(unitID, "clone") then
        return true
    end
    return false
end

function Clones:AddIdle(unitID)
    self.idle:PushLeft(unitID)
end

function Clones:CommandIdles(attackXPos)
    while self.idle:Size() > 0 do
        local unitID = self.idle:PopRight()
        if not Spring.GetUnitIsDead(unitID) then
            local cQueue = Spring.GetCommandQueue(unitID, 1)
            if cQueue and #cQueue == 0 then
                local x, y, z = Spring.GetUnitPosition(unitID)
                Spring.GiveOrderToUnit(unitID, CMD.INSERT, {-1, CMD.FIGHT, CMD.OPT_SHIFT, attackXPos, 0, z}, {"alt"})
            end
        end
    end
end

function Clones:ClearTimedOut(frame)
    self:ClearUnitType(self.timeout.heavy, heavyTimeout, frame)
    self:ClearUnitType(self.timeout.normal, normalTimeout, frame)
    self:ClearUnitType(self.timeout.skirm, skirmTimeout, frame)
    self:ClearUnitType(self.timeout.arty, artyTimeout, frame)
    self:ClearUnitType(self.timeout.antiAir, antiairTimeout, frame)
end

------------------------------
-- Private Functions
------------------------------

function Clones:ClearUnitType(typeQueue, timeout, frame)
    while typeQueue:Size() > 0 and typeQueue:PeekRight().frame + timeout < frame do
        local units = typeQueue:PopRight().units
        for i = 1, #units do
            if not Spring.GetUnitIsDead(units[i]) then
                Spring.DestroyUnit(units[i], false, true)
            end
        end
    end
end

return Clones
