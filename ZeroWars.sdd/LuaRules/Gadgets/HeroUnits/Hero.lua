local spSetUnitRulesParam = Spring.SetUnitRulesParam
local spSetTeamRulesParam = Spring.SetTeamRulesParam
local spSetUnitPosition = Spring.SetUnitPosition

local spGetUnitRulesParam = Spring.GetUnitRulesParam
local spGetUnitPosition = Spring.GetUnitPosition


local function callScript(unitID, funcName, args)
    local func = Spring.UnitScript.GetScriptEnv(unitID)[funcName]
    if func then
        Spring.UnitScript.CallAsUnit(unitID, func, args)
    end
end

Hero = {}
Hero.__index = Hero

function Hero.new(unitID, unitDefID, spawnPoint, deathPoint)
    local instance = {
        _ID = unitID,
        _DefID = unitDefID,
        _spawnPoint = spawnPoint,
        _deathPoint = deathPoint,
        _isDead = true,
        _respawnFrame = 0
    }
    setmetatable(instance, Hero)

    spSetUnitRulesParam(unitID, "xp", 0)
    spSetUnitRulesParam(unitID, "level", 1)
    spSetUnitRulesParam(unitID, "points", 0)
    spSetUnitRulesParam(unitID, "path1", 0)
    spSetUnitRulesParam(unitID, "path2", 0)
    spSetUnitRulesParam(unitID, "path3", 0)
    spSetUnitRulesParam(unitID, "path4", 0)

    return instance
end

function Hero:update(frame)
    if self._isDead and self._respawnFrame == -1 then
        self._respawnFrame = frame
    end
end

function Hero:giveXP(xp)
    local newXP = self:getXP() + xp
    spSetUnitRulesParam(self._ID, "xp", newXP)
end

function Hero:levelUp()

end

function Hero:upgrade(pathID)

end

function Hero:canRespawn(frame)
    return self._isDead and frame >= self._respawnFrame
end

function Hero:spawn()
    spSetUnitPosition(self._ID, self._spawnPoint.x, self._spawnPoint.z, true)
    self._isDead = false
    self._respawnFrame= -1
end

function Hero:die()
    spSetUnitPosition(self._ID, self._deathPoint.x, self._deathPoint.z, true)
    self._isDead = true
end

function Hero:getXP()
    return spGetUnitRulesParam(self._ID, "xp")
end

function Hero:getPosition()
    local x, y, z = spGetUnitPosition(self._ID)
    return {x = x, z = z}
end

return Hero
