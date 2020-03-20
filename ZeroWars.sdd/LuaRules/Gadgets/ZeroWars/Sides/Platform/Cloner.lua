include("LuaRules/Configs/customcmds.h.lua")
local Queue = VFS.Include("LuaRules/Gadgets/ZeroWars/Data/Queue.lua")

local spGetUnitTeam = Spring.GetUnitTeam
local spGetUnitDefID = Spring.GetUnitDefID
local spGetUnitStates = Spring.GetUnitStates
local spGetUnitHealth = Spring.GetUnitHealth
local spGetUnitPosition = Spring.GetUnitPosition
local spFindUnitCmdDesc = Spring.FindUnitCmdDesc
local spGetUnitCmdDescs = Spring.GetUnitCmdDescs

local spCreateUnit = Spring.CreateUnit
local spSetUnitNoSelect = Spring.SetUnitNoSelect
local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGiveOrderArrayToUnitArray = Spring.GiveOrderArrayToUnitArray
local spEditUnitCmdDesc = Spring.EditUnitCmdDesc

Cloner = {}
Cloner.__index = Cloner

function Cloner:Create(deployRect, faceDir, attackXPos)
    local o = {}
    setmetatable(o, Cloner)
    o.deployRect = deployRect
    o.faceDir = faceDir
    o.attackXPos = attackXPos
    o.spawnAmount = 12
    o.queue = Queue:New()
    return o
end

function Cloner:Add(platform)
    local units = platform:GetUnits()

    if not units then
        return
    end
    for i = #units, 1, -1 do
        local buildProgress = select(5, spGetUnitHealth(units[i]))
        if buildProgress ~= 1 then
            table.remove(units, i)
        end
    end
    if not units then
        return
    end

    while (#units > 0) do
        local deployGroup = {
            units = self:SubsetClones(units, 1, math.min(self.spawnAmount, #units)),
            platform = platform
        }
        self.queue:PushLeft(deployGroup)
    end
end

function Cloner:Deploy()
    local deployGroup = self.queue:PopRight()
    local clones = {}
    local units = deployGroup.units
    local platform = deployGroup.platform
    local offset = platform.rect:GetPosOffset(self.deployRect)
    local teamID = spGetUnitTeam(units[1])

    for i = 1, #units do
        local unitDefID = spGetUnitDefID(units[i])
        local x, y, z = spGetUnitPosition(units[i])
        local clone = spCreateUnit(unitDefID, x + offset.x, 150, z + offset.y, self.faceDir, teamID)
        self:CopyUnitStates(units[i], clone)
        spGiveOrderToUnit(
            clone,
            CMD.INSERT,
            {-1, CMD.FIGHT, CMD.OPT_SHIFT, self.attackXPos, 128, z + offset.y},
            {"alt"}
        )
        clones[i] = clone
    end

    return clones, units
end

function Cloner:Size()
    return self.queue:Size()
end

------------------------------
-- Private Functions
------------------------------

function Cloner:SubsetClones(clones, from, to)
    local subset = {}
    local iterator = 1
    for i = to, from, -1 do
        subset[iterator] = clones[i]
        iterator = iterator + 1
        table.remove(clones, i)
    end
    return subset
end

function Cloner:CopyUnitStates(original, clone)
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

    self:CopyUnitState(original, clone, CMD_UNIT_AI)
    self:CopyUnitState(original, clone, CMD_AIR_STRAFE)
    self:CopyUnitState(original, clone, CMD_PUSH_PULL)
    self:CopyUnitState(original, clone, CMD_AP_FLY_STATE)
    self:CopyUnitState(original, clone, CMD_UNIT_BOMBER_DIVE_STATE)
    self:CopyUnitState(original, clone, CMD_AP_FLY_STATE)
end

function Cloner:CopyUnitState(original, clone, cmd)
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

return Cloner
