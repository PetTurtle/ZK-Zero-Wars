
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

local LABEL_SIZE = 10
local LABEL_HEIGHT = 10

local mexUpgradeCmdDesc = {
    type     = CMDTYPE.ICON,
    name     = 'Upgrade Mex',
    cursor   = 'Morph',
    action   = 'mexupgrade',
    texture  = 'LuaUI/Images/metalplus.png'
}

local upgrades = {
    {
        income = 2,
        cost = 300,
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

local function getCmdDescTooltip(level)
    local upgrade = upgrades[level]
    return "Upgrade Mex (Level " .. (level + 1) .. "):"
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
                GG.UnitLabel.Set(unitID, "level: " .. (lvl + 1), LABEL_SIZE, LABEL_HEIGHT)
            else
                GG.UnitLabel.Set(unitID, "level: MAX", LABEL_SIZE, LABEL_HEIGHT)
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
        GG.UnitLabel.Set(unitID, "level: 1", LABEL_SIZE, LABEL_HEIGHT)
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

    mexUpgradeCmdDesc.id = upgrades[1].cmd
    mexUpgradeCmdDesc.tooltip = getCmdDescTooltip(1)
end
