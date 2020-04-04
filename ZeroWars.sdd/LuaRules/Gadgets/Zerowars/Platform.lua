local spCreateUnit = Spring.CreateUnit
local spSetUnitResourcing = Spring.SetUnitResourcing
local spSetUnitBlocking = Spring.SetUnitBlocking

local spGetPlayerList = Spring.GetPlayerList
local spGetUnitsInRectangle = Spring.GetUnitsInRectangle

Platform = {}
Platform.__index = Platform

function Platform.new(rect)
    local instance = {
        _rect = rect,
        _teamList = {}
    }
    setmetatable(instance, Platform)
    rect:setOutlineBuildMask(0)
    return instance
end

function Platform:onStart(units)
    local xOffset = self._rect:getX()
    local zOffset = self._rect:getZ()

    for i = 1, #self._teamList do
        for j = 1, #units do
            local unitID =
                spCreateUnit(
                units[j].unitName,
                xOffset + units[j].x,
                100,
                zOffset + units[j].z,
                units[j].dir,
                self._teamList[i]
            )
            spSetUnitResourcing(unitID, "umm", units[j].metalIncome or 0)
            spSetUnitResourcing(unitID, "ume", units[j].energyIncome or 0)
            spSetUnitBlocking(unitID, units[j].isBlocking or true, units[j].isBlocking or true)
        end
    end
end

function Platform:addTeam(teamID)
    table.insert(self._teamList, teamID)
end

function Platform:removeTeam(teamID)
    table.remove(self._teamList, teamID)
end

function Platform:hasTeam(teamID)
    for i = 1, #self._teamList do
        if self._teamList[i] == teamID then
            return true
        end
    end
    return false
end

function Platform:isActive()
    return #self._teamList > 0
end

function Platform:getUnits()
    local platformUnits = {}
    for i, team in pairs(self._teamList) do
        if spGetPlayerList(team, true) then
            local units =
                spGetUnitsInRectangle(
                self._rect:getX(),
                self._rect:getZ(),
                self._rect:getX2(),
                self._rect:getZ2(),
                team
            )
            if units and #units > 0 then
                table.insert(platformUnits, {units = units, team = team})
            end
        end
    end
    return platformUnits
end

function Platform:getOffset(rect)
    return self._rect:getOffset(rect)
end

return Platform
