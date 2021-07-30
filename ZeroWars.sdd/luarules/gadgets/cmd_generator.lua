function gadget:GetInfo()
    return {
        name = "CMD Generator",
        desc = "returns unique cmd id",
        author = "petturtle",
        date = "2021",
        license = "GNU GPL, v2 or later",
        layer = -10,
        enabled = true,
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

local nameToCMD = VFS.Include("LuaRules/Configs/customcmds.lua", nil, VFS.GAME)

local cmdToName = {}
local maxCMDID = 0

function gadget:Initialize()
    for cmdName, cmdID in pairs(nameToCMD) do
        cmdToName[cmdID] = cmdName

        if cmdID > maxCMDID then
            maxCMDID = cmdID
        end
    end

    GG.CMDGenerator = {
        Generate = function(cmdName)
            maxCMDID = maxCMDID + 1
            cmdToName[maxCMDID] = cmdName
            nameToCMD[cmdName] = maxCMDID
            return maxCMDID
        end,

        GetCMDName = function(cmdID)
            return cmdToName[cmdID]
        end,

        GetCMDID = function(cmdName)
            return nameToCMD(cmdName)
        end
    }
end
