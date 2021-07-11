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
local units = {}
local groups = {}

function gadget:AllowCommand(unitID, unitDefID, unitTeam, cmdID, cmdParams, cmdOptions, cmdTag, synced)
  local isAllowed = true 
  local groupID = units[unitID]

  if groupID then
    isAllowed = groups[groupID][cmdID]
    if isAllowed and groups[groupID].filter then
      isAllowed = groups[groupID].filter(unitID, unitDefID, cmdID, cmdParams, cmdOptions, cmdTag, synced)
    end

    Spring.Echo(cmdID .. ", " .. tostring(synced) .. " : " .. tostring(isAllowed))
  end

  return isAllowed
end

function gadget:Initialize()
  GG.UnitCMDBlocker = {
    Lock = function ()
      unlocked = false
    end,

    Unlock = function ()
      unlocked = true
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
