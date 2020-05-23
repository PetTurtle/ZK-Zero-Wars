function gadget:GetInfo()
    return {
        name = "Control Point",
        desc = "gives metal to owner, can be captured",
        author = "petturtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true
    }
end

if not gadgetHandler:IsSyncedCode() then return false end

-----------------------------------------
-----------------------------------------

-- SyncedCtrl
local spCreateUnit = Spring.CreateUnit
local spTransferUnit = Spring.TransferUnit
local spSetUnitResourcing = Spring.SetUnitResourcing

-- SyncedRead
local spGetUnitTeam = Spring.GetUnitTeam
local spGetUnitNearestAlly = Spring.GetUnitNearestAlly
local spGetUnitNearestEnemy = Spring.GetUnitNearestEnemy

local UPDATEFRAME = 30
local NEUTRALTEAM = Spring.GetGaiaTeamID()
local CAPTURERANGE = 200

local controlPoints = {}

local function createControlPoint(x, y, z, metal, team)
    local unitID = spCreateUnit("controlpoint", x, y, z, "n",
                                team or NEUTRALTEAM)

    GG.SetUnitInvincible(unitID, true)
    spSetUnitResourcing(unitID, "umm", metal)
    controlPoints[unitID] = true
end

local function capture(unitID, captiveID)
    local teamID = spGetUnitTeam(captiveID)
    spTransferUnit(unitID, teamID, false)
end

local function update(unitID)
    local nearestAlly = spGetUnitNearestAlly(unitID, CAPTURERANGE)
    local nearestEnemy = spGetUnitNearestEnemy(unitID, CAPTURERANGE, false)

    if nearestEnemy and not nearestAlly then capture(unitID, nearestEnemy) end
end

function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end

    GG.createControlPoint = createControlPoint
end

function gadget:GameFrame(frame)
    if frame > 0 and frame % UPDATEFRAME == 0 then
        for controlPoint, True in pairs(controlPoints) do
            update(controlPoint)
        end
    end
end

function gadget:UnitDestroyed(unitID)
    if controlPoints[unitID] then
        table.remove(controlPoints, unitID)
    end
end