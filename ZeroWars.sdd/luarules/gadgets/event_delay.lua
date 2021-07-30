function gadget:GetInfo()
    return {
        name = "Event Delay",
        desc = "run event after delay (frames)",
        author = "PetTurtle",
        date = "2021",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

local currentFrame = 0
local eventBuffer = {}

function gadget:GameFrame(frame)
    currentFrame = frame
    if #eventBuffer > 0 then
        local delayed = {}

        for i = 1, #eventBuffer do
            local event = eventBuffer[i]
            if event.frame <= frame then
                event.run()
            else
                delayed[#delayed + 1] = event
            end
        end

        eventBuffer = delayed
    end
end

function gadget:Initialize()
    GG.EventDelay = function (delay, event)
        eventBuffer[#eventBuffer + 1] = {
            run = event,
            frame = currentFrame + delay
        }
    end
end
