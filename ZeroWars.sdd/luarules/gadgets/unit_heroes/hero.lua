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

local HeroUnitDefs = VFS.Include("luarules/configs/hero_defs.lua")

local LABEL_SIZE = 12
local LABEL_HEIGHT = 30

local function levelXP(level) return 100 * level * level + 500 end

local function totalLevelXP(level)
    local total = 0
    for i = 0, level do total = total + levelXP(i) end
    return total
end

local Hero = {}
Hero.__index = Hero

function Hero.new(unitID, unitDefID)
    local ud = UnitDefs[unitDefID]

    local instance = {
        _ID = unitID,
        _upgadeDefs = HeroUnitDefs[ud.name],
        _maxLevel = false,
        dead = false,
    }
    setmetatable(instance, Hero)

    spSetUnitRulesParam(unitID, "xp", 0)
    spSetUnitRulesParam(unitID, "level", 0)
    spSetUnitRulesParam(unitID, "points", 0)
    spSetUnitRulesParam(unitID, "path1", 0)
    spSetUnitRulesParam(unitID, "path2", 0)
    spSetUnitRulesParam(unitID, "path3", 0)
    spSetUnitRulesParam(unitID, "path4", 0)
    GG.UnitLabel.Set(unitID, "Level: 1", LABEL_SIZE, LABEL_HEIGHT)

    local onReady = instance._upgadeDefs.onReady
    if onReady then
        for i = 1, #onReady do
            local param = onReady[i]
            GG.EditUnit(instance._ID, param[1], param[2] or nil,
                        param[3] or nil, param[4] or nil, param[5] or nil)
        end
    end

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
        local pathLvl = spGetUnitRulesParam(self._ID, pathID) + 1
        if pathLvl <= #self._upgadeDefs[pathID] then
            local level = spGetUnitRulesParam(self._ID, "level")
            local requiredUpgrades = self._upgadeDefs[pathID][pathLvl]
                                         .requiredUpgrades
            if requiredUpgrades <= level - points then
                local params = self._upgadeDefs[pathID][pathLvl].params
                for i = 1, #params do
                    local param = params[i]
                    GG.EditUnit(self._ID, param[1], param[2] or nil,
                                param[3] or nil, param[4] or nil,
                                param[5] or nil)
                end
                spSetUnitRulesParam(self._ID, pathID, pathLvl)
                spSetUnitRulesParam(self._ID, "points", points - 1)
            end
        end
    end
end

function Hero:levelUp()
    if not self._maxLevel then
        local level = spGetUnitRulesParam(self._ID, "level") + 1
        spSetUnitRulesParam(self._ID, "level", level)
        GG.UnitLabel.Set(self._ID, "Level: " .. level, LABEL_SIZE, LABEL_HEIGHT)

        local points = spGetUnitRulesParam(self._ID, "points")
        spSetUnitRulesParam(self._ID, "points", points + 1)


        local onLevelUp = self._upgadeDefs.onLevelUp
        if onLevelUp then
            for i = 1, #onLevelUp do
                local param = onLevelUp[i]
                GG.EditUnit(self._ID, param[1], param[2] or nil,
                            param[3] or nil, param[4] or nil, param[5] or nil)
            end
        end

        if level == 16 then self._maxLevel = true end
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

function Hero:setPosition(pos) spSetUnitPosition(self._ID, pos.x, pos.y, pos.z) end

function Hero:getXP() return spGetUnitRulesParam(self._ID, "xp") end

function Hero:getKillXP()
    local level = spGetUnitRulesParam(self._ID, "level")
    return levelXP(level) / 3
end

function Hero:getTotalXP()
    local currXP = spGetUnitRulesParam(self._ID, "xp")
    local level = spGetUnitRulesParam(self._ID, "level")
    local totalXP = totalLevelXP(level - 1)
    return totalXP + currXP
end

function Hero:getLevel() return spGetUnitRulesParam(self._ID, "level") end

function Hero:getPosition()
    local x, y, z = spGetUnitPosition(self._ID)
    return {x = x, y = y, z = z}
end

return Hero
