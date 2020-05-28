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

local Map = VFS.Include("luarules/gadgets/util/map.lua")
local Side = VFS.Include("luarules/gadgets/zerowars/side.lua")
local centerBuildings, platformBuildings, platforms = VFS.Include("luarules/configs/zerowars_map.lua")

local map = Map.new()
local sides = {}
local leftAllyTeamID, rightAllyTeamID

local function GenerateSides()
    leftAllyTeamID, rightAllyTeamID = map:getAllyTeams()
    sides[tonumber(leftAllyTeamID)] = Side.new(leftAllyTeamID, centerBuildings[1], platformBuildings[1], platforms[1])
    sides[tonumber(rightAllyTeamID)] = Side.new(rightAllyTeamID, centerBuildings[2], platformBuildings[2], platforms[2])
end

function gadget:GamePreload()
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
