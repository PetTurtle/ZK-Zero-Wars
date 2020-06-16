function gadget:GetInfo()
    return {
        name = "Unit Cloner",
        desc = "clones unit and it's state",
        author = "petturtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

-----------------------------------------
-----------------------------------------

include("LuaRules/Configs/customcmds.h.lua")

-- SyncedCtrl
local spCreateUnit = Spring.CreateUnit
local spEditUnitCmdDesc = Spring.EditUnitCmdDesc
local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGiveOrderArrayToUnitArray = Spring.GiveOrderArrayToUnitArray

-- SyncedRead
local spGetUnitDefID = Spring.GetUnitDefID 
local spGetUnitIsDead = Spring.GetUnitIsDead
local spGetUnitStates = Spring.GetUnitStates
local spGetUnitCmdDescs = Spring.GetUnitCmdDescs
local spFindUnitCmdDesc = Spring.FindUnitCmdDesc

local function transferUnitState(originalID, cloneID, cmd)
    local CMDDescID = spFindUnitCmdDesc(originalID, cmd)
    if CMDDescID then
        local cmdDesc = spGetUnitCmdDescs(originalID, CMDDescID, CMDDescID)
        if cmdDesc and #cmdDesc > 0 then
            local nparams = cmdDesc[1].params
            spEditUnitCmdDesc(cloneID, cmd, cmdDesc[1])
            spGiveOrderToUnit(cloneID, cmd, {nparams[1]}, {})
        end
    end
end

local function transferUnitStates(originalID, cloneID)
    local states = spGetUnitStates(originalID)
    spGiveOrderArrayToUnitArray(
        {cloneID},
        {
            {CMD.FIRE_STATE, {states.firestate}, {}},
            {CMD.MOVE_STATE, {states.movestate}, {}},
            {CMD.REPEAT, {states["repeat"] and 1 or 0}, {}},
            {CMD.CLOAK, {states.cloak and 1 or 0}, {}},
            {CMD.ONOFF, {1}, {}},
            {CMD.TRAJECTORY, {states.trajectory and 1 or 0}, {}}
        }
    )

    transferUnitState(originalID, cloneID, CMD_UNIT_AI)
    transferUnitState(originalID, cloneID, CMD_AIR_STRAFE)
    transferUnitState(originalID, cloneID, CMD_PUSH_PULL)
    transferUnitState(originalID, cloneID, CMD_AP_FLY_STATE)
    transferUnitState(originalID, cloneID, CMD_UNIT_BOMBER_DIVE_STATE)
    transferUnitState(originalID, cloneID, CMD_AP_FLY_STATE)
end

local function cloneUnit(unitID, x, y, z, faceDir, teamID)
    if not spGetUnitIsDead(unitID) then
        unitDefID = spGetUnitDefID(unitID)
        cloneID = spCreateUnit(unitDefID, x, y, z, faceDir, teamID)
        transferUnitStates(unitID, cloneID)
        return cloneID
    end
    return nil
end

function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end

    GG.cloneUnit = cloneUnit
end