local RespawnPool = {}
RespawnPool.__index = RespawnPool

-------------------------------------
-- Creates RespawnPool
-- @param spawnPoint {x, y, z}
-- @param deathPoint {x, y, z}
-------------------------------------
function RespawnPool.new(spawnPoint, deathPoint)
    local instance = {
        _spawnPoint = spawnPoint,
        _deathPoint = deathPoint,
        _pool = {}
    }
    setmetatable(instance, RespawnPool)
    return instance
end

-------------------------------------
-- Moves hero to respawn zone
-- @param hero hero class
-------------------------------------
function RespawnPool:addHero(hero)
    local currentFrame = Spring.GetGameFrame()
    local deathFrame = currentFrame
    self:_OnHeroDeath(hero, currentFrame, deathFrame)
end

function RespawnPool:update(frame)
    for i, data in pairs(self._pool) do
        self:_OnHeroUpdate(data.hero, i, frame, data.deathFrame, data.respawnFrame)
    end
end

-------------------------------------
-- @param hero hero class
-------------------------------------
function RespawnPool:_OnHeroDeath(hero, currentFrame, deathFrame)
    local respawnFrame = 4 * (30) * (hero:getLevel() + 1) + currentFrame
    table.insert(self._pool, {hero = hero, deathFrame = deathFrame, respawnFrame = respawnFrame})

    hero:heal()
    hero:setPosition(self._deathPoint)
    Spring.SetUnitNeutral(hero._ID, true)
    Spring.SetUnitBlocking(hero._ID, false, false, false, false, false, false, false)
    Spring.SetUnitHealth(hero._ID, {paralyze = 99999999})
end

-------------------------------------
-- @param hero hero class
-------------------------------------
function RespawnPool:_OnHeroUpdate(hero, poolID, currentFrame, deathFrame, respawnFrame)
    if respawnFrame <= currentFrame then
        self:_OnHeroRespawn(hero)
        table.remove(self._pool, poolID)
    else
        local buildAmount = (currentFrame - deathFrame) / math.max(1, respawnFrame - deathFrame)
        Spring.SetUnitHealth(hero._ID, {build = buildAmount})
        hero:setPosition(self._spawnPoint)
    end
end

-------------------------------------
-- @param hero hero class
-------------------------------------
function RespawnPool:_OnHeroRespawn(hero)
    hero:heal()
	hero:setPosition(self._spawnPoint)
	Spring.SetUnitNeutral(hero._ID, false)
    Spring.SetUnitHealth(hero._ID, {build = 1, paralyze = 0})
    Spring.SetUnitBlocking(hero._ID, true, true, true, true, true, true, true)
end

return RespawnPool