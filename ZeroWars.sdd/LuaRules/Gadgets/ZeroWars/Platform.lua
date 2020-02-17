local Rect = VFS.Include("LuaRules/Gadgets/ZeroWars/Rect.lua")

local spCreateUnit = Spring.CreateUnit
local spGetTeamUnits = Spring.GetTeamUnits
local spSetUnitPosition = Spring.SetUnitPosition

local Platform = {}

function Platform.new(platform_Layout, offsetX, offsetY)
    local pl = platform_Layout
    local rect = Rect.new(pl.x1, pl.y1, pl.x2, pl.y2)
    local playerList = {}

    local platform = {
        rect = rect,
        playerList = playerList,
        offsetX = offsetX,
        offsetY = offsetY,
    }

    function platform:AddPlayer(playerID)
        table.insert(self.playerList, playerID)
    end

    function platform:HasPlayer(playerID)
        for i = 1, #self.playerList do
            if self.playerList[i] == playerID then return true end
        end return false
    end

    function platform:Deploy(platUnits)
        local playerUnits = platUnits.playerUnits
        local comPos = platUnits.customParams["COMMANDER_SPAWN"]

        for i = 1, #self.playerList do
            for j = 1, #playerUnits do
                self.rect:CreateUnit(playerUnits[j].unitName, playerUnits[j].x, playerUnits[j].z, playerUnits[j].dir, self.playerList[i])
            end

            -- move commander
            units = spGetTeamUnits(self.playerList[i])
            spSetUnitPosition(units[1], comPos.x, comPos.z)
        end
    end

    return platform
end

return Platform