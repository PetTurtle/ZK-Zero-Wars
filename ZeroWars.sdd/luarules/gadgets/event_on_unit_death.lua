function gadget:GetInfo()
    return {
        name = "On Unit Death Event",
        desc = "run event on unit death",
        author = "petturtle",
        date = "2021",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true,
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

local events = {}

function gadget:UnitDestroyed(unitID)
    if events[unitID] then
        events[unitID]()
        table.remove(events, unitID)
    end
end

function gadget:Initialize()
    GG.EventOnUnitDeath = function (unitID, event)
        events[unitID] = event
    end
end
