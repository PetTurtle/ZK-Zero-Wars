function gadget:GetInfo()
    return {
        name = "Deploy Zones",
        desc = "creates zones that duplicate units",
        author = "petturtle",
        date = "2021",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

local spCreateUnit = Spring.CreateUnit
local spGetUnitDefID = Spring.GetUnitDefID
local spGetUnitHealth = Spring.GetUnitHealth
local spGetGroundHeight = Spring.GetGroundHeight
local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitsInRectangle = Spring.GetUnitsInRectangle

local zones = {}

local function Deploy(zoneID)

    local zone = zones[zoneID]
    local selectedUnits = spGetUnitsInRectangle(zone.x, zone.z, zone.x + zone.width, zone.z + zone.height, zone.teamID, true, false)
    local newUnits = {}

    for i = 1, #selectedUnits do
        if zone.blackList[selectedUnits[i]] == nil then

            local buildProgress = select(5, spGetUnitHealth(selectedUnits[i]))

            if buildProgress >= 1.0 then
                local x, _, z = spGetUnitPosition(selectedUnits[i])
                local newX = x + zone.offsetX
                local newZ = z + zone.offsetZ
                local newY = spGetGroundHeight(newX, newZ)
                local unitDefID = spGetUnitDefID(selectedUnits[i])
                local newUnit = spCreateUnit(unitDefID, newX, newY, newZ, zone.faceDir, zone.teamID, true)
                newUnits[#newUnits+1] = newUnit
            
                GG.AutoBuild(newUnit, UnitDefs[unitDefID].metalCost / zone.buildTime)
            end

        end
    end
    
    return newUnits
end

local function Create(x, z, targetX, targetZ, width, height, teamID, faceDir, buildTime)
    zones[#zones+1] = {
        x = x,
        z = z,
        width = width,
        height = height,
        offsetX = targetX - x,
        offsetZ = targetZ - z,
        teamID = teamID,
        faceDir = faceDir,
        buildTime = buildTime,
        blackList = {}
    }
    return #zones
end

local function Destory(zoneID)
    zones[zoneID] = nil
end

local function Blacklist(zoneID, unitID)
    zones[zoneID].blackList[unitID] = true
end

function gadget:Initialize()
    GG.DeployZones = {
        Deploy = Deploy,
        Create = Create,
        Destory = Destory,
        Blacklist = Blacklist
    }
end