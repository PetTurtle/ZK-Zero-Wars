function gadget:GetInfo()
  return {
    name = "Unit Widget CMD Blocker",
    desc = "Blocks widget commands given to specific units.",
    author = "PetTurtle",
    date = "2020",
    license = "GNU GPL, v2 or later",
    layer = 0,
    enabled = true,
  }
end

if not gadgetHandler:IsSyncedCode() then
  return false
end

local unlocked = false
local blocked = {}

function gadgetHandler:AllowCommand(unitID, _, _, cmdID, _, _, _, _, fromSynced)
  return fromSynced or unlocked or not (blocked[unitID] and blocked[unitID][cmdID])
end

function gadget:Initialize()
  local UnitWidgetCMDBlocker = {
    function Lock()
      unlocked = false
    end,

    function Unlock()
      unlocked = true
    end,

    function AppendUnit(unitID)
      blocked[unitID] = {}
    end,

    function RemoveUnit(unitID)
      blocked[unitID] = nil
    end,

    function UnitAllowCmds(unitID, cmdID)
      for _, cmdID in pairs(cmds) do
        blocked[unitID][cmdID] = true
      end
    end,
  }

  GG.UnitWidgetCMDBlocker = UnitWidgetCMDBlocker
end
