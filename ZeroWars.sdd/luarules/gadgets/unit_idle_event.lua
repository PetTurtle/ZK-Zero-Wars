function gadget:GetInfo()
    return {
        name = "Idle Event",
        desc = "call function when unit is idle",
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
local eventBuffer = {}

function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end

    GG.AddOnIdleEvent = function (unitID, event)
        events[unitID] = event
    end
end

function gadget:GameFrame(frame)
    if #eventBuffer > 0 then
        for i = 1, #eventBuffer do
            if events[eventBuffer[i]] then
                events[eventBuffer[i]]()
            end
        end
        eventBuffer = {}
    end
end

function gadget:UnitDestroyed(unitID)
    if events[unitID] then
        table.remove(events, unitID)
    end
end

function gadget:UnitIdle(unitID, unitDefID, unitTeam)
    if events[unitID] then
        eventBuffer[#eventBuffer+1] = unitID
    end
end