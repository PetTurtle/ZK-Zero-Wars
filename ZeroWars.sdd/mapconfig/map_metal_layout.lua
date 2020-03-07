function GetPlayerList(allyID)
    local playerList = Spring.GetTeamList(allyID)

    -- remove nullAI from player list
    for i = #playerList, 1, -1 do
        local luaAI = Spring.GetTeamLuaAI(playerList[i])
        if luaAI and string.find(string.lower(luaAI), "ai") then
            table.remove(playerList, i)
        end
    end

	return playerList
end

local allyTeamList = Spring.GetAllyTeamList()
local leftTeam = GetPlayerList(allyTeamList[1])
local rightTeam = GetPlayerList(allyTeamList[2])

local totalPlayers = #leftTeam + #rightTeam

local leftMetal = 3.5 
local rightMetal = 3.5

local ret = {}
table.insert(ret, {x = 4096, z = 1532, metal = 2.0 * totalPlayers})

if #leftTeam <= 1 then
    table.insert(ret, {x = 140, z = 1349, metal = leftMetal})
    table.insert(ret, {x = 140, z = 1734, metal = leftMetal})
elseif #leftTeam <= 2 then
    table.insert(ret, {x = 140, z = 1349, metal = leftMetal})
    table.insert(ret, {x = 140, z = 1734, metal = leftMetal})
    table.insert(ret, {x = 140, z = 2381, metal = leftMetal})
    table.insert(ret, {x = 140, z = 2766, metal = leftMetal})
else
    table.insert(ret, {x = 140, z = 1349, metal = leftMetal})
    table.insert(ret, {x = 140, z = 1734, metal = leftMetal})
    table.insert(ret, {x = 140, z = 2381, metal = leftMetal})
    table.insert(ret, {x = 140, z = 2766, metal = leftMetal})
    table.insert(ret, {x = 140, z = 325, metal = leftMetal})
    table.insert(ret, {x = 140, z = 710, metal = leftMetal})
end

if #rightTeam <= 1 then
    table.insert(ret, {x = 8052, z = 1349, metal = rightMetal})
    table.insert(ret, {x = 8052, z = 1734, metal = rightMetal})
elseif #rightTeam <= 2 then
    table.insert(ret, {x = 8052, z = 1349, metal = rightMetal})
    table.insert(ret, {x = 8052, z = 1734, metal = rightMetal})
    table.insert(ret, {x = 8052, z = 2381, metal = rightMetal})
    table.insert(ret, {x = 8052, z = 2766, metal = rightMetal})
else
    table.insert(ret, {x = 8052, z = 1349, metal = rightMetal})
    table.insert(ret, {x = 8052, z = 1734, metal = rightMetal})
    table.insert(ret, {x = 8052, z = 2381, metal = rightMetal})
    table.insert(ret, {x = 8052, z = 2766, metal = rightMetal})
    table.insert(ret, {x = 8052, z = 325, metal = rightMetal})
    table.insert(ret, {x = 8052, z = 710, metal = rightMetal})
end

return { spots = ret }
