local Platform = VFS.Include("LuaRules/Gadgets/ZeroWars/platform_layout.lua")

local Side = {}

local spGetTeamList = Spring.GetTeamList
local spGetTeamLuaAI = Spring.GetTeamLuaAI

-- side : side of map "left", "right"
function Side.new(allyID, side, attackXPos)

    local playerList = spGetTeamList(allyID)
    local nullAI = -1
    local platforms = Platform.new(side)

    -- remove nullAI from team list
    for i = 1, #playerList do
        local luaAI = spGetTeamLuaAI(playerList[i])
        if luaAI and string.find(string.lower(luaAI), "ai") then
            nullAI = playerList[i]
            table.remove(playerList, i)
        end
    end

    -- assign players to platforms
    for i = 1, #playerList do
        table.insert(platforms[(i % #platforms) + 1].players, playerList[i])
    end

    -- remove platforms with no players
    for i = #platforms, 1, -1 do
        if #platforms[i].players == 0 then
            table.remove(platforms, i)
        end
    end

    local side = {
        allyID = allyID,
        nullAI = nullAI,
        playerList = playerList,
        platforms = platforms,
        attackXPos = attackXPos,
        baseId = -1,
        turretId = -1,
        iterator = 0
    }

    return side
end

return Side