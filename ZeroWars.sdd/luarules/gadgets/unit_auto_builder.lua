function gadget:GetInfo()
    return {
        name = "Unit Auto Builder",
        desc = "simulates the building of a unit without using builders",
        author = "petturtle",
        date = "2021",
        layer = -10,
        enabled = true
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

local buildings = {}
local buildingCount = 0

local function addUnitAt(ID, unitID, metalPS, metalCost)

    local health, maxHealth = Spring.GetUnitHealth(unitID)
    Spring.SetUnitHealth(unitID, {health = maxHealth * 0.25})

    buildings[ID] = {
        unitID = unitID,
        buildSpeed = metalPS / metalCost,
        metalPS = metalPS,
        metalLeft = metalCost + 10,
    }

    if ID == buildingCount + 1 then
        buildingCount = buildingCount + 1
    end
end

local function removeUnitAt(ID)
    buildings[ID] = nil
end

local function isValidUnit(unitID)
    return Spring.ValidUnitID(unitID) and not Spring.GetUnitIsDead(unitID)
end

local function giveMetal(metalAmount, teamID)
    local teamMetal = Spring.GetTeamResources(teamID, "metal")
    Spring.SetTeamResource(teamID, "m", teamMetal + metalAmount)
end

local function AutoBuild(unitID, metalPS)
    if not isValidUnit(unitID) then
        return
    end

    local unitDefID = Spring.GetUnitDefID(unitID)
    local metalCost = UnitDefs[unitDefID].metalCost

    for i = 1, buildingCount do
        if buildings[i] == nil then
            addUnitAt(i, unitID, metalPS, metalCost)
            return
        end
    end

    addUnitAt(buildingCount + 1, unitID, metalPS, metalCost)
end

function gadget:GameFrame(frame)
    if not (frame % 30 == 0) then
        return
    end

    for i = 1, buildingCount do
        local building = buildings[i]
        if not (building == nil) then
            if not (isValidUnit(building.unitID)) then
                removeUnitAt(i)

            else
                local health, maxHealth, _, _, buildProgress = Spring.GetUnitHealth(building.unitID)
                
                if health and health > 0 then
                    building.metalLeft = building.metalLeft - building.metalPS

                    local newHealth = math.min(health + (maxHealth * building.buildSpeed), maxHealth)
                    local newBuild = math.min(buildProgress + building.buildSpeed, 1)

                    Spring.SetUnitHealth(building.unitID, {health = newHealth, build = newBuild})

                    if building.metalLeft <= 0 then
                        removeUnitAt(i)

                    elseif buildProgress == 1 then
                        local teamID = Spring.GetUnitTeam(building.unitID)
                        giveMetal(building.metalLeft, teamID)
                        removeUnitAt(i)

                    end
                else
                    removeUnitAt(i)
                end
            end
        end
    end
end

function gadget:Initialize()
    GG.AutoBuild = AutoBuild
end