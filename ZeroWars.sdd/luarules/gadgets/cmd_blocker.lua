function gadget:GetInfo()
  return {
    name = "CMD Blocker",
    desc = "blocks cmds given to units",
    author = "PetTurtle",
    date = "2021",
    license = "GNU GPL, v2 or later",
    layer = -999,
    enabled = true,
  }
end

if not gadgetHandler:IsSyncedCode() then
  return false
end

local locked = true
local units = {}
local groups = {}

function gadget:AllowCommand(unitID, unitDefID, unitTeam, cmdID, cmdParams, cmdOptions, cmdTag, synced)
  local isAllowed = true
  local groupID = units[unitID]

  if groupID and locked then
    isAllowed = groups[groupID][cmdID]
    if isAllowed and groups[groupID].filter then
      isAllowed = groups[groupID].filter(unitID, unitDefID, cmdID, cmdParams, cmdOptions, cmdTag, synced)
    end
  end

  return isAllowed
end

function gadget:Initialize()
  GG.UnitCMDBlocker = {
    Lock = function ()
      locked = true
    end,

    Unlock = function ()
      locked = false
    end,

    AppendUnit = function (unitID, groupID)
      groupID = groupID or 0
      units[unitID] = groupID

      if not groups[groupID] then
        groups[groupID] = {}
      end
    end,

    RemoveUnit = function (unitID)
      units[unitID] = nil
    end,

    AllowCommand = function (groupID, cmdID)
      if not groups[groupID] then
        groups[groupID] = {}
      end

      groups[groupID][cmdID] = true
    end,

    AppendFilter = function (groupID, filter)
      if not groups[groupID] then
        groups[groupID] = {}
      end

      groups[groupID].filter = filter
    end
  }
end
