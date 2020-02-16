function CreateTeam(nullAI)
    local allyTeam = select(6, Spring.GetTeamInfo(nullAI, false))
    local playerList = Spring.GetTeamList(allyTeam)

    -- remove nullAI from player list
    for i = 1, #playerList do
        if (playerList[i] == nullAI) then
            table.remove(playerList, i)
        end
    end

	local team = {
		nullAI = nullAI,
		allyTeam = allyTeam,
		playerList = playerList
    }
	return team
end

local teams = Spring.GetTeamList()
local nullAI = {}
for i = 1, #teams do
    local luaAI = Spring.GetTeamLuaAI(teams[i])
    if luaAI and string.find(string.lower(luaAI), "ai") then
        table.insert(nullAI, teams[i])
    end
end

local leftTeam = CreateTeam(nullAI[1])
local rightTeam = CreateTeam(nullAI[2])

local ret = {}
table.insert(ret, {x = 4096, z = 1532, metal = 4.0})

if #leftTeam.playerList <= 1 then
    table.insert(ret, {x = 140, z = 1349, metal = 2.0})
    table.insert(ret, {x = 140, z = 1734, metal = 2.0})
elseif #leftTeam.playerList <= 2 then
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

if #rightTeam.playerList <= 1 then
    table.insert(ret, {x = 8052, z = 1349, metal = 2.0})
    table.insert(ret, {x = 8052, z = 1734, metal = 2.0})
elseif #rightTeam.playerList <= 2 then
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
