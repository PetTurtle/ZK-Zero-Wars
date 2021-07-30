function gadget:GetInfo()
    return {
        name = "Unit Movement Blocker",
        desc = "blocks unit from moving",
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

local unitBuffer = {}

-- need to stop unit movement the next frame to revent weird behavour with newly made units
function gadget:GameFrame(frame)
    if #unitBuffer > 0 then
        for i = 1, #unitBuffer do
            Spring.MoveCtrl.Enable(unitBuffer[i], false)
        end
        unitBuffer = {}
    end
end

function gadget:Initialize()
    GG.BlockUnitMovement = {
        Block = function (unitID)
            unitBuffer[#unitBuffer+1] = unitID
        end,

        Unblock = function (unitID)
            Spring.MoveCtrl.Enable(unitID, true)
        end
    }
end