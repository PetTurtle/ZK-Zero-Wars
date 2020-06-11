function gadget:GetInfo()
    return {
        name = "Unit Uncapturable",
        desc = "call function when unit dies",
        author = "petturtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true,
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

-----------------------------------------
-----------------------------------------

local _units = {}

function UnitUncapturable(unitID)
    _units[unitID] = true
end

function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end

    GG.UnitUncapturable = UnitUncapturable
end

function gadget:AllowUnitTransfer(unitID)
    return not _units[unitID]
end

function gadget:UnitDestroyed(unitID)
    if _units[unitID] then
        _units[unitID] = nil
    end
end