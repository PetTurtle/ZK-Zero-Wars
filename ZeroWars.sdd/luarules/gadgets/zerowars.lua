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

local Map = include("luarules/gadgets/util/map.lua")
local centerBuildings, platformBuildings = include("luarules/configs/zerowars_map.lua")

if gadgetHandler:IsSyncedCode() then
    local map
    local leftTeam, rightTeam

    function gadget:GamePreload()
        map = Map.new()
        leftTeam, rightTeam = map:getTeamSides()

        for i, building in pairs(centerBuildings[1]) do
            Spring.CreateUnit(building.unitName, building.x, 128, building.z, building.dir, leftTeam)
        end

        for i, building in pairs(centerBuildings[2]) do
            Spring.CreateUnit(building.unitName, building.x, 128, building.z, building.dir, rightTeam)
        end

        -- spawn buildings
    end

    function gadget:AllowStartPosition(playerID, teamID, readyState, clampedX, clampedY, clampedZ, rawX, rawY, rawZ)
        -- assign player to platform
        return true
    end
else -- UNSYNCED
    function gadget:Initialize()
    end

    function gadget:Shutdown()
    end
end
