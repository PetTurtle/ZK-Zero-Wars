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

local ret = {}
table.insert(ret, {x = 4096, z = 1532, metal = 4.0})

if #leftTeam <= 1 then
    table.insert(ret, {x = 140, z = 1349, metal = 2.0})
    table.insert(ret, {x = 140, z = 1734, metal = 2.0})
elseif #leftTeam <= 2 then
    table.insert(ret, {x = 140, z = 1349, metal = 2.0})
    table.insert(ret, {x = 140, z = 1734, metal = 2.0})
    table.insert(ret, {x = 140, z = 2381, metal = 2.0})
    table.insert(ret, {x = 140, z = 2766, metal = 2.0})
else
    table.insert(ret, {x = 140, z = 1349, metal = 2.0})
    table.insert(ret, {x = 140, z = 1734, metal = 2.0})
    table.insert(ret, {x = 140, z = 2381, metal = 2.0})
    table.insert(ret, {x = 140, z = 2766, metal = 2.0})
    table.insert(ret, {x = 140, z = 325, metal = 2.0})
    table.insert(ret, {x = 140, z = 710, metal = 2.0})
end

if #rightTeam <= 1 then
    table.insert(ret, {x = 8052, z = 1349, metal = 2.0})
    table.insert(ret, {x = 8052, z = 1734, metal = 2.0})
elseif #rightTeam <= 2 then
    table.insert(ret, {x = 8052, z = 1349, metal = 2.0})
    table.insert(ret, {x = 8052, z = 1734, metal = 2.0})
    table.insert(ret, {x = 8052, z = 2381, metal = 2.0})
    table.insert(ret, {x = 8052, z = 2766, metal = 2.0})
else
    table.insert(ret, {x = 8052, z = 1349, metal = 2.0})
    table.insert(ret, {x = 8052, z = 1734, metal = 2.0})
    table.insert(ret, {x = 8052, z = 2381, metal = 2.0})
    table.insert(ret, {x = 8052, z = 2766, metal = 2.0})
    table.insert(ret, {x = 8052, z = 325, metal = 2.0})
    table.insert(ret, {x = 8052, z = 710, metal = 2.0})
end

return { spots = ret }
