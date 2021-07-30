local RespawnPool = VFS.Include("luarules/gadgets/unit_heroes/respawn_pool.lua")

local HeroTeam = {}
HeroTeam.__index = HeroTeam

function HeroTeam.new(allyTeamID, layout)
    local instance = {
        _heroes = {},
        _allyTeamID = allyTeamID,
        _layout = layout,
        _respawnPool = RespawnPool.new(layout.spawnPoint, layout.respawnPoint)
    }
    setmetatable(instance, HeroTeam)
    return instance
end


function HeroTeam:GameStart()
    local teamList = Spring.GetTeamList(self._allyTeamID)
    local respawnPoint = self._layout.respawnPoint
    for _, teamID in pairs(teamList) do
        Spring.CreateUnit("chicken_drone_starter", respawnPoint.x, respawnPoint.y, respawnPoint.z, self._layout.faceDir, teamID)
    end
end

function HeroTeam:update(frame)
    self._respawnPool:update(frame)
end

-------------------------------------
-- Share xp between heroes around position
-- @param pos {x, z}
-- @param xp shared between heroes
-------------------------------------
function HeroTeam:shareXP(pos, xp)
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
function HeroTeam:addHero(heroID, hero)
    self._heroes[heroID] = hero
end

-------------------------------------
-- Removes Hero from HeroTeam (usually from selfD)
-- @param heroID
-------------------------------------
function HeroTeam:removeHero(heroID)
    assert(self._heroes[heroID])
    self._heroes[heroID] = nil
end

-------------------------------------
-- @param hero hero class
-------------------------------------
function HeroTeam:heroDied(hero)
    self._respawnPool:addHero(hero)
end

function HeroTeam:getHeroes()
    return self._heroes
end

-------------------------------------
-- Get all heroes around point
-- @param center {x, z}
-- @param radius around center
-------------------------------------
function HeroTeam:getHeroesInRange(center, radius)
    local inRange = {}
    for heroID, hero in pairs(self._heroes) do
        local pos = hero:getPosition()
        if math.sqrt(math.pow(center.x - pos.x, 2) + math.pow(center.z - pos.z, 2)) <= radius then
            inRange[#inRange + 1] = hero
        end
    end
    return inRange
end

function HeroTeam:getAllyTeamID()
    return self._allyTeamID
end

return HeroTeam
