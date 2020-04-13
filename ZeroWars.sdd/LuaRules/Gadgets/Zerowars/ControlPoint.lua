-- SyncedCtrl
local spCreateUnit = Spring.CreateUnit
local spTransferUnit = Spring.TransferUnit
local spSetUnitNeutral = Spring.SetUnitNeutral
local spSetUnitResourcing = Spring.SetUnitResourcing
local spSetUnitRulesParam = Spring.SetUnitRulesParam

-- SyncedRead
local spGetUnitTeam = Spring.GetUnitTeam
local spGetUnitNearestAlly = Spring.GetUnitNearestAlly
local spGetUnitNearestEnemy = Spring.GetUnitNearestEnemy

local neutralTeam = Spring.GetGaiaTeamID()
local captureRange = 200
local LOS_ACCESS = {inlos = true}

-------------------------------------
-- Call function in unit script
-------------------------------------
local function callScript(unitID, funcName, args)
    local func = Spring.UnitScript.GetScriptEnv(unitID)[funcName]
    if func then
        Spring.UnitScript.CallAsUnit(unitID, func, args)
    end
end

local ControlPoint = {}
ControlPoint.__index = ControlPoint

function ControlPoint.new(pos, metal)
    local instance = {
        _ID = spCreateUnit("controlpoint", pos.x, pos.y, pos.z, "n", neutralTeam),
        _metal = metal,
        _captured = false,
        _active = false
    }

    GG.SetUnitInvincible(instance._ID, true)
    setmetatable(instance, ControlPoint)
    return instance
end

function ControlPoint:update()
    local nearestAlly = spGetUnitNearestAlly(self._ID, captureRange)
    local nearestEnemy = spGetUnitNearestEnemy(self._ID, captureRange, false)

    if self._captured then
        if nearestEnemy then
            if nearestAlly then
                self:_deactivate()
            else
                self:_capture(nearestEnemy)
                self:_activate()
            end
        else
            self:_activate()
        end
    elseif nearestEnemy then
        self:_capture(nearestEnemy)
        self:_activate()
    end

    if nearestEnemy then
        if nearestAlly then
        else
            local enemyTeamID = spGetUnitTeam(nearestEnemy)
            spTransferUnit(self._ID, enemyTeamID, false)
        end
    else
    end
end

function ControlPoint:_capture(unit)
    local teamID = spGetUnitTeam(unit)
    self._captured = true
    spTransferUnit(self._ID, teamID, false)
end

function ControlPoint:_activate()
    if not self._active then
        callScript(self._ID, "activate", {})
        spSetUnitResourcing(self._ID, "umm", self._metal)
        self._active = true
    end
end

function ControlPoint:_deactivate()
    if self._active then
        callScript(self._ID, "deactivate", {})
        spSetUnitResourcing(self._ID, "umm", 0)
        self._active = false
    end
end

return ControlPoint
