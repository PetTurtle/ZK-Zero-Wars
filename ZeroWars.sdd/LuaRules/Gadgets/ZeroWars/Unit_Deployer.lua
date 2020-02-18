local spGetUnitDefID = Spring.GetUnitDefID

local Unit_Deployer = {}

function Unit_Deployer.new()

    local function ValidUnit(unitID, ud)
        local buildProgress = select(5, Spring.GetUnitHealth(unitID))
        if not ud.isImmobile and (not ud.isMobileBuilder or ud.isAirUnit) and buildProgress == 1 then
            return true end
        return false 
    end

    local function CopyUnitState(original, clone, cmd)
        local CMDDescID = Spring.FindUnitCmdDesc(original, cmd)
            if CMDDescID then
                local cmdDesc = Spring.GetUnitCmdDescs(original, CMDDescID, CMDDescID)
                local nparams = cmdDesc[1].params
                Spring.EditUnitCmdDesc(clone, cmd, cmdDesc[1])
                Spring.GiveOrderToUnit(clone, cmd, {nparams[1]}, {})
            end
    end

    local function DeployPlatform(platform, deployRect, faceDir, nullAI, attackXPos)
        for k = 1, #platform.playerList do
            local units = platform:GetUnits(platform.playerList[k])
            if units then
                local posDif = platform.rect:GetPosDifference(deployRect)
                for i = 1, #units do
                    local unitDefID = spGetUnitDefID(units[i])
                    local ud = UnitDefs[unitDefID]
                    if ValidUnit(units[i], ud) then
                        local x, y, z = Spring.GetUnitPosition(units[i])
                        
                        local unit = Spring.CreateUnit(unitDefID, posDif.x + x, 150, posDif.y + z, faceDir, nullAI)

                        local states = Spring.GetUnitStates(units[i])
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

                        Spring.GiveOrderToUnit(unit, CMD.FIGHT, {attackXPos, 0, z}, 0)
                    end
                end
            end
        end
    end

    local unit_deployer = {
        ValidUnit = ValidUnit,
        CopyUnitState = CopyUnitState,
        DeployPlatform = DeployPlatform,
    }

    return unit_deployer
end

return Unit_Deployer