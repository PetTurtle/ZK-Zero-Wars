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
local platforms, deployRects, buildings  = VFS.Include("luarules/configs/map_zerowars.lua")

local sides = {}
local map = Map.new()

local function GenerateSides()
    allyStarts = map:getAllyStarts()
    allyStarts.Left = tonumber(allyStarts.Left or 0)
    allyStarts.Right = tonumber(allyStarts.Right or 0)
    sides[allyStarts.Left] = Side.new(allyStarts.Left,  platforms.Left, deployRects.Left, buildings.Left)
    sides[allyStarts.Right] = Side.new(allyStarts.Right, platforms.Right, deployRects.Right, buildings.Right)
end

function gadget:GamePreload()
    GenerateSides()
end

function gadget:GameStart()
    map:replaceStartUnit("builder")
    map:setMetalStorage(300)
end

function gadget:Initialize()
end

function gadget:GameOver()
    gadgetHandler:RemoveGadget(self)
end
