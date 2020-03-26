include("LuaRules/Configs/customcmds.h.lua")

local spEditUnitCmdDesc = Spring.EditUnitCmdDesc
local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGiveOrderArrayToUnitArray = Spring.GiveOrderArrayToUnitArray

local spFindUnitCmdDesc = Spring.FindUnitCmdDesc
local spGetUnitStates = Spring.GetUnitStates
local spGetUnitCmdDescs = Spring.GetUnitCmdDescs

StateCopier = {}
StateCopier.__index = StateCopier

function StateCopier.new()
    local instance = {}
    setmetatable(instance, StateCopier)
    return instance
end

function StateCopier:copyUnitStates(original, clone)
    local states = spGetUnitStates(original)
    spGiveOrderArrayToUnitArray(
        {clone},
        {
            {CMD.FIRE_STATE, {states.firestate}, {}},
            {CMD.MOVE_STATE, {states.movestate}, {}},
            {CMD.REPEAT, {states["repeat"] and 1 or 0}, {}},
            {CMD.CLOAK, {states.cloak and 1 or 0}, {}},
            {CMD.ONOFF, {1}, {}},
            {CMD.TRAJECTORY, {states.trajectory and 1 or 0}, {}}
        }
    )

    self:copyUnitState(original, clone, CMD_UNIT_AI)
    self:copyUnitState(original, clone, CMD_AIR_STRAFE)
    self:copyUnitState(original, clone, CMD_PUSH_PULL)
    self:copyUnitState(original, clone, CMD_AP_FLY_STATE)
    self:copyUnitState(original, clone, CMD_UNIT_BOMBER_DIVE_STATE)
    self:copyUnitState(original, clone, CMD_AP_FLY_STATE)
end

------------------------------
-- Private Functions
------------------------------

function StateCopier:copyUnitState(original, clone, cmd)
    local CMDDescID = spFindUnitCmdDesc(original, cmd)
    if CMDDescID then
        local cmdDesc = spGetUnitCmdDescs(original, CMDDescID, CMDDescID)
        if cmdDesc and #cmdDesc > 0 then
            local nparams = cmdDesc[1].params
            spEditUnitCmdDesc(clone, cmd, cmdDesc[1])
            spGiveOrderToUnit(clone, cmd, {nparams[1]}, {})
        end
    end
end

return StateCopier
