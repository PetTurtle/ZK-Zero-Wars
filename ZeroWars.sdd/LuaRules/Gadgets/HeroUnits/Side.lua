local RespawnPool = VFS.Include("LuaRules/Gadgets/HeroUnits/RespawnPool.lua")

local Side = {}
Side.__index = Side

function Side.new(allyTeamID, layout)
    local instance = {
        _heroes = {},
        _allyTeamID = allyTeamID,
        _layout = layout,
        _respawnPool = RespawnPool.new(layout.spawnPoint, layout.respawnPoint)
    }
    setmetatable(instance, Side)
    return instance
end

function Side:update(frame)
    self._respawnPool:update(frame)
end

-------------------------------------
-- Share xp between heroes around position
-- @param pos {x, z}
-- @param xp shared between heroes
-------------------------------------
function Side:shareXP(pos, xp)
    local heroes = self:getHeroesInRange(pos, 1000)
    local heroCount = #heroes
    for i = 1, heroCount do
        heroes[i]:giveXP(xp / heroCount)
    end
end

-------------------------------------
-- Add New Hero, usually when player chooses one
-- @param hero hero class
-------------------------------------
function Side:addHero(hero)
    local heroes = self._heroes
    heroes[#heroes + 1] = hero
    self._respawnPool:addHero(hero)
end

-------------------------------------
-- @param hero hero class
-------------------------------------
function Side:heroDied(hero)
    self._respawnPool:addHero(hero)
end

function Side:getHeroes()
    return self._heroes
end

-------------------------------------
-- Get all heroes around point
-- @param center {x, z}
-- @param radius around center
-------------------------------------
function Side:getHeroesInRange(center, radius)
    local inRange = {}
    for i, hero in pairs(self._heroes) do
        local pos = hero:getPosition()
        if math.sqrt(math.pow(center.x - pos.x, 2) + math.pow(center.z - pos.z, 2)) <= radius then
            inRange[#inRange + 1] = hero
        end
    end
    return inRange
end

function Side:getLayout()
    return self._layout
end

function Side:getAllyTeamID()
    return self._allyTeamID
end

return Side
