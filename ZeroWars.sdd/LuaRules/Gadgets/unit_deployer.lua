if not gadgetHandler:IsSyncedCode() then return false end

function gadget:GetInfo()
    return {
        name = "Unit Deployer",
        desc = "Deploys units for each player to the center",
        author = "petturtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 8,
        enabled = true,
        handler = true
    }
end

include("LuaRules/Configs/customcmds.h.lua")
local Wave = VFS.Include("LuaRules/Gadgets/ZeroWData/Wave.lua")

local spawnTime = 800 -- #frames between waves
local updateTime = 60

local leftSide
local rightSide

local WAVETIMEOUT = 6000
local ARTYTIMEOUT = 3000
local waves = {}
local artyWave = {}

local function CopyUnitState(original, clone, cmd)
    local CMDDescID = Spring.FindUnitCmdDesc(original, cmd)
        if CMDDescID then
            local cmdDesc = Spring.GetUnitCmdDescs(original, CMDDescID, CMDDescID)
            local nparams = cmdDesc[1].params
            Spring.EditUnitCmdDesc(clone, cmd, cmdDesc[1])
            Spring.GiveOrderToUnit(clone, cmd, {nparams[1]}, {})
        end
end

local function DeployUnit(unitDefID, copyID, x, z, playerID, faceDir)
    local unit = Spring.CreateUnit(unitDefID, x, 150, z, faceDir, playerID)
    
    
end

local function DeployWave(side, units, frame, faceDir)
    local plat = side.platforms[side.iterator + 1]
    local spawnedUnits = {}
    local spawnedArty = {}
    for i = 1, #units do
        local unitDefID = Spring.GetUnitDefID(units[i])
        local x, y, z = Spring.GetUnitPosition(units[i])
        local states = Spring.GetUnitStates(units[i])
        local buildProgress = select(5, Spring.GetUnitHealth(units[i]))
        local ud = UnitDefs[unitDefID]
        if ud.customParams.commtype then
            Spring.SetUnitPosition(units[i], x + plat.offsetX, z + plat.offsetY)
        elseif not ud.isImmobile and (not ud.isMobileBuilder or ud.isAirUnit) and buildProgress == 1  then
            local unit = Spring.CreateUnit(unitDefID, x + plat.offsetX, 150, z + plat.offsetY, faceDir, side.nullAI)
            if (ud.maxWeaponRange >= 600) then
                table.insert(spawnedArty, unit)
            else
                table.insert(spawnedUnits, unit)
            end
            Spring.GiveOrderArrayToUnitArray({ unit }, {
                { CMD.FIRE_STATE, { states.firestate },             { } },
                { CMD.MOVE_STATE, { states.movestate },             { } },
                { CMD.REPEAT,     { states["repeat"] and 1 or 0 },  { } },
                { CMD.CLOAK,      { states.cloak     and 1 or ud.initCloaked },  { } },
                { CMD.ONOFF,      { 1 },                            { } },
                { CMD.TRAJECTORY, { states.trajectory and 1 or 0 }, { } },
            })
            
            CopyUnitState(units[i], unit, CMD_UNIT_AI)
            CopyUnitState(units[i], unit, CMD_AIR_STRAFE)
            CopyUnitState(units[i], unit, CMD_PUSH_PULL)
            CopyUnitState(units[i], unit, CMD_AP_FLY_STATE)
            CopyUnitState(units[i], unit, CMD_UNIT_BOMBER_DIVE_STATE)
            CopyUnitState(units[i], unit, CMD_AP_FLY_STATE)

            Spring.GiveOrderToUnit(unit, CMD.FIGHT, {side.attackXPos, 0, z + plat.offsetY}, 0)
        end
    end
    if #spawnedUnits > 0 then
        table.insert(waves, Wave.new(spawnedUnits, frame))
    end
    if #spawnedArty > 0 then
        table.insert(artyWave, Wave.new(spawnedArty, frame))
    end
end

local function DeployPlatform(side, frame, faceDir)
    local plat = side.platforms[side.iterator + 1]
    for i = 1, #plat.players do
        local units = Spring.GetUnitsInRectangle(plat.deployRect.x1, plat.deployRect.y1, plat.deployRect.x2, plat.deployRect.y2, plat.players[i])
        if #units > 0 then
            DeployWave(side, units, frame, faceDir)
        end
    end
end

local function IteratePlatform(side, frame, faceDir)
    DeployPlatform(side, frame, faceDir)
    side.iterator=((side.iterator + 1) % #side.platforms)
end

local function TimeOutWave(waves, timeOutTime, frame)
    if #waves > 0 and waves[1].spawnFrame + timeOutTime < frame then
        local units = waves[1].units
        for i = 1, #units do
            if not Spring.GetUnitIsDead(units[i]) then
                Spring.DestroyUnit(units[i], false, true)
            end
        end
        table.remove(waves, 1)
    end
end

function gadget:Initialize()
    leftSide = GG.leftSide
    rightSide = GG.rightSide
end

function gadget:GameFrame(f)
    if f % spawnTime == 0 then
        IteratePlatform(leftSide, f, "e")
        IteratePlatform(rightSide, f, "w")
    end

    if f % updateTime == 0 then
        TimeOutWave(waves, WAVETIMEOUT, f)
        TimeOutWave(artyWave, ARTYTIMEOUT, f)
    end
end