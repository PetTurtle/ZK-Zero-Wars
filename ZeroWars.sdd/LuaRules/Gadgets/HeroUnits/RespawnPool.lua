-- SyncedRead
local spGetGameFrame = Spring.GetGameFrame

RespawnPool = {}
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
    local respawnTime = self:_getHeroRespawnTime(hero)
    table.insert(self._pool, {hero = hero, respawnTime = respawnTime})
    hero:setPosition(self._deathPoint)
end

function RespawnPool:update(frame)
    local pool = self._pool
    for i, hero in pairs(pool) do
        local respawnTime = hero.respawnTime
        if respawnTime <= frame then
            self:_respawnHero(hero.hero)
            table.remove(pool, i)
        end
    end
end

-------------------------------------
-- @param hero hero class
-------------------------------------
function RespawnPool:_getHeroRespawnTime(hero)
    local frame = spGetGameFrame()
    local heroLevel = hero:getLevel()
    return 4 * (30) * (heroLevel + 1) + frame -- 4 seconds * herolevel
end

-------------------------------------
-- @param hero hero class
-------------------------------------
function RespawnPool:_respawnHero(hero)
    hero:heal()
    hero:setPosition(self._spawnPoint)
end

return RespawnPool
