-- SyncedCtrl
local spSetUnitRulesParam = Spring.SetUnitRulesParam
local spSetTeamRulesParam = Spring.SetTeamRulesParam
local spSetUnitMaxHealth = Spring.SetUnitMaxHealth
local spSetUnitPosition = Spring.SetUnitPosition
local spSetUnitHealth = Spring.SetUnitHealth

-- SyncedRead
local spGetUnitRulesParam = Spring.GetUnitRulesParam
local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitHealth = Spring.GetUnitHealth

local HeroUnitDefs = include("LuaRules/Configs/Hero_Unit_Defs.lua")

-------------------------------------
-- Call function in unit script
-------------------------------------
local function callScript(unitID, funcName, args)
    local func = Spring.UnitScript.GetScriptEnv(unitID)[funcName]
    if func then
        Spring.UnitScript.CallAsUnit(unitID, func, args)
    end
end

local function levelXP(level)
    return 100*level*level + 500
end

local function totalLevelXP(level)
    local total = 0
    for i = 0, level do
        total = total + levelXP(i)
    end
    return total
end

local Hero = {}
Hero.__index = Hero

function Hero.new(unitID, unitDefID)
    local ud = UnitDefs[unitDefID]

    local instance = {
        _ID = unitID,
        _upgadeDefs = HeroUnitDefs[ud.name],
        _maxLevel = false
    }
    setmetatable(instance, Hero)

    spSetUnitRulesParam(unitID, "xp", 0)
    spSetUnitRulesParam(unitID, "level", 0)
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

function Hero:upgrade(unitDefID, unitTeam, pathID)
    local points = spGetUnitRulesParam(self._ID, "points")
    if points > 0 then
        local pathLvl = spGetUnitRulesParam(self._ID, pathID)
        if pathLvl < 4 then
            pathLvl = pathLvl + 1

            spSetUnitRulesParam(self._ID, pathID, pathLvl)
            spSetUnitRulesParam(self._ID, "points", points - 1)
            self._upgadeDefs[pathID][pathLvl].upgrade(self._ID, unitDefID, unitTeam)

            self:_updateStats()
        end
    end
end

function Hero:levelUp()
    if not self._maxLevel then
        local level = spGetUnitRulesParam(self._ID, "level") + 1
        spSetUnitRulesParam(self._ID, "level", level)

        local points = spGetUnitRulesParam(self._ID, "points")
        spSetUnitRulesParam(self._ID, "points", points + 1)

        self:_updateStats()

        if level == 16 then
            self._maxLevel = true
        end
    end
end

function Hero:giveXP(xp)
    if not self._maxLevel then
        local newXP = self:getXP() + xp
        local level = spGetUnitRulesParam(self._ID, "level")
        local xpNeeded = levelXP(level)

        while newXP >= xpNeeded do
            self:levelUp()
            newXP = math.max(0, newXP - xpNeeded)
        end

        if self._maxLevel then
            spSetUnitRulesParam(self._ID, "xp", xpNeeded)
        else
            spSetUnitRulesParam(self._ID, "xp", newXP)
        end
    end
end

function Hero:heal()
    local maxHealth = select(2, spGetUnitHealth(self._ID))
    spSetUnitHealth(self._ID, maxHealth)
end

function Hero:setPosition(pos)
    spSetUnitPosition(self._ID, pos.x, pos.y, pos.z)
end

function Hero:getXP()
    return spGetUnitRulesParam(self._ID, "xp")
end

function Hero:getTotalXP()
    local currXP = spGetUnitRulesParam(self._ID, "xp")
    local level = spGetUnitRulesParam(self._ID, "level")
    local totalXP = totalLevelXP(level-1)
    return totalXP + currXP
end

function Hero:getLevel()
    return spGetUnitRulesParam(self._ID, "level")
end

function Hero:getPosition()
    local x, y, z = spGetUnitPosition(self._ID)
    return {x = x, y = y, z = z}
end

function Hero:_updateStats()
    local unitID = self._ID
    local stats = self._upgadeDefs.stats
    local level = spGetUnitRulesParam(unitID, "level")
    local scale = (level / 16) * (stats.maxScale - stats.minScale) + stats.minScale

    GG.UnitScale(unitID, scale)
    
    local armour = spGetUnitRulesParam(unitID, "armour") or 0
    local currHealth, currMaxHealth = spGetUnitHealth(unitID)
    local newMaxHealth = (level / 16) * (stats.maxHP - stats.minHP) + stats.minHP + armour
    local newHealth = currHealth * newMaxHealth / currMaxHealth
    spSetUnitMaxHealth(unitID, newMaxHealth)
    spSetUnitHealth(unitID, newHealth)
end

return Hero
