function gadget:GetInfo()
    return {
        name = "Zero-Wars Mod",
        desc = "zero-k autobattler",
        author = "petturtle",
        date = "2020",
        layer = 0,
        enabled = true
    }
end

if (not gadgetHandler:IsSyncedCode()) then
    return false
end

local Side = VFS.Include("luarules/gadgets/zerowars/side.lua")
local getAllyStarts = VFS.Include("luarules/configs/map_ally_starts.lua")
local centerBuildings, platformBuildings, platforms = VFS.Include("luarules/configs/map_zerowars.lua")

local sides = {}
local allyStarts

local function GenerateSides()
    allyStarts.Left = tonumber(allyStarts.Left or 0)
    allyStarts.Right = tonumber(allyStarts.Right or 0)
    sides[allyStarts.Left] = Side.new(allyStarts.Left, centerBuildings[1], platformBuildings[1], platforms[1])
    sides[allyStarts.Right] = Side.new(allyStarts.Right, centerBuildings[2], platformBuildings[2], platforms[2])
end

function gadget:GamePreload()
    allyStarts = getAllyStarts()

    GenerateSides()
end

function gadget:AllowStartPosition(playerID, teamID, readyState, clampedX, clampedY, clampedZ, rawX, rawY, rawZ)
    local allyTeamID = select(6, Spring.GetTeamInfo(teamID))
    sides[allyTeamID]:updatePlayerSpawn(playerID, clampedX, clampedZ)
    return true
end

function gadget:Initialize()
end

function gadget:GameOver()
    gadgetHandler:RemoveGadget(self)
end
