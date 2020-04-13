local spCreateUnit = Spring.CreateUnit
local spSetUnitNeutral = Spring.SetUnitNeutral
local spSetUnitNoSelect = Spring.SetUnitNoSelect
local spSetUnitBlocking = Spring.SetUnitBlocking

local spGetTeamList = Spring.GetTeamList

local Side = {}
Side.__index = Side

function Side.new(allyID, platforms)
    local instance = {
        _allyID = allyID,
        _platforms = platforms,
        _iterator = 0,
        _baseID = -1,
        _turretID = -1
    }
    setmetatable(instance, Side)

    -- assign teams to platforms
    local teamList = spGetTeamList(allyID)
    for i = 1, #teamList do
        platforms[(i % #platforms) + 1]:addTeam(teamList[i])
    end

    instance:removeEmptyPlatforms()

    return instance
end

function Side:onStart(buildings, playerUnits, platformBuildings)
    local baseID, turretId
    local mainTeam = spGetTeamList(self._allyID)[1]
    for i = 1, #buildings do
        local unit =
            spCreateUnit(buildings[i].unitName, buildings[i].x, 100, buildings[i].z, buildings[i].dir, mainTeam)
        spSetUnitBlocking(unit, false, false)
        spSetUnitNoSelect(unit, buildings[i].noSelectable or false)
        spSetUnitNeutral(unit, buildings[i].neutral or false)

        if buildings[i].unitName == "baseturret" then
            self._baseID = unit
        elseif buildings[i].unitName == "centerturret" then
            self._turretID = unit
        end
    end

    -- deploy platforms
    for i = 1, #self._platforms do
        self._platforms[i]:onStart(playerUnits, platformBuildings)
    end
end

function Side:nextPlatform()
    self._iterator = ((self._iterator + 1) % #self._platforms)
end

function Side:getUnits()
    return self._platforms[self._iterator + 1]:getUnits()
end

function Side:getOffset(rect)
    return self._platforms[self._iterator + 1]:getOffset(rect)
end

function Side:removeTeam(teamID)
    for i = #self._platforms, 1, -1 do
        if self._platforms[i]:hasTeam(teamID) then
            self._platforms[i]:removeTeam(teamID)
            if not self._platforms[i]:isActive() then
                table.remove(self._platforms, i)
            end
            return
        end
    end
end

function Side:getAllyID()
    return self._allyID
end

function Side:getBaseID()
    return self._baseID
end

function Side:getTurretID()
    return self._turretID
end

------------------------------
-- Private Functions
------------------------------

function Side:removeEmptyPlatforms()
    -- remove platforms with no teams
    for i = #self._platforms, 1, -1 do
        if not self._platforms[i]:isActive() then
            table.remove(self._platforms, i)
        end
    end
end

return Side
