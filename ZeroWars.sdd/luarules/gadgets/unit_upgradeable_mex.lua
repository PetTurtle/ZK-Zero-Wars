
function gadget:GetInfo()
    return {
        name = "Upgradeable Mex",
        desc = "makes mex upgradeable",
        author = "petturtle",
        date = "2021",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true,
        handler = true
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

include("LuaRules/Configs/customcmds.h.lua")

local mex = {}
local mexDefID = UnitDefNames["upgradeablemex"].id
local CMD_MEX_UPGRADE = 55367
local DEFAULT_INCOME = 1

local mexUpgradeCmdDesc = {
    type     = CMDTYPE.ICON,
    name     = 'Upgrade Mex',
    cursor   = 'Morph',
    action   = 'mexupgrade',
    texture  = 'LuaUI/Images/noammo.png'
}

local upgrades = {
    {
        income = 2,
        cost = 250,
        scale = 1.2,
    },
    {
        income = 2,
        cost = 500,
        scale = 1.4,
    },
    {
        income = 3,
        cost = 1050,
        scale = 1.6,
    },
    {
        income = 4,
        cost = 2000,
        scale = 1.8,
    },
    {
        income = 5,
        cost = 4000,
        scale = 2.0,
    }
}

local function getMexUpgradeCmdDesc(cmdID)
    local lvl = cmdID - CMD_MEX_UPGRADE + 1
    local tooltip = "Upgrade Mex (Level " .. lvl .. "):"
                 .. "\nIncome: +" .. upgrades[lvl].income .. "m/s"
                 .. "\nCost: " .. upgrades[lvl].cost .. "m"
                 .. "\nPayback In: " .. (upgrades[lvl].cost / upgrades[lvl].income) .. "s"

    return {
        id       = CMD_MEX_UPGRADE + lvl - 1,
        tooltip  = tooltip,
    }
end

local function getCmdDescTooltip(level)
    local upgrade = upgrades[level]
    return "Upgrade Mex (Level " .. level .. "):"
          .. "\nIncome: +" .. upgrade.income .. "m/s:"
          .. "\nCost: " .. upgrade.cost .. "m"
          .. "\nPayback In: " .. (upgrade.cost /  upgrade.income) .. "s"

end

function gadget:UnitCommand(unitID, unitDefID, unitTeam, cmdID, cmdParams, cmdOptions, cmdTag)
    if mex[unitID] and mex[unitID].cmdID == cmdID then
        local cmdDescID = Spring.FindUnitCmdDesc(unitID, cmdID)
        if cmdDescID == nil then return end

        local lvl = mex[unitID].level
        local teamID = Spring.GetUnitTeam(unitID)

        if Spring.UseTeamResource(teamID, "metal", upgrades[lvl].cost) then
            GG.Overdrive.AddUnitResourceGeneration(unitID, upgrades[lvl].income, 0, true)
            GG.UnitScale(unitID, upgrades[lvl].scale)

            if upgrades[lvl + 1] then
                mex[unitID].level = lvl + 1
                mex[unitID].cmdID = upgrades[lvl + 1].cmd
                local tooltip = getCmdDescTooltip(lvl + 1)
                local cmdDesc = {id = mex[unitID].cmdID, tooltip = tooltip}
                Spring.EditUnitCmdDesc(unitID, cmdDescID, cmdDesc)
            else
                Spring.RemoveUnitCmdDesc(unitID, cmdDescID)
                table.remove(mex, unitID)
            end
        end
    end
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
    if unitDefID == mexDefID then
        mex[unitID] = {
            cmdID = upgrades[1].cmd,
            level = 1
        }
        GG.Overdrive.AddUnitResourceGeneration(unitID, DEFAULT_INCOME, 0, true)
        Spring.InsertUnitCmdDesc(unitID, mexUpgradeCmdDesc)
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerID)
    if mex[unitID] then
        table.remove(mex, unitID)
    end
end

function gadget:Initialize()
    for i = 1, #upgrades do
        upgrades[i].cmd = GG.CMDGenerator.Generate("MEX_UPGRADE_" .. i)
    end

    local cmdDesc = getMexUpgradeCmdDesc(CMD_MEX_UPGRADE)
    mexUpgradeCmdDesc.id = upgrades[1].cmd
    mexUpgradeCmdDesc.tooltip = cmdDesc.tooltip
end
