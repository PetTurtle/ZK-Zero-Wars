function gadget:GetInfo()
    return {
        name = "Death Event",
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

local _events = {}

function AddOnDeathEvent(unitID, event)
    _events[unitID] = event
end

function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end

    GG.AddOnDeathEvent = AddOnDeathEvent
end

function gadget:UnitDestroyed(unitID)
    if _events[unitID] then
        _events[unitID]()
    end
end