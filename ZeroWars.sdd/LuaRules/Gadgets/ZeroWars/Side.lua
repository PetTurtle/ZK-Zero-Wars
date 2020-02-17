local PlatformLayout = VFS.Include("LuaRules/Gadgets/ZeroWars/platform_layout.lua")
local SideUnitLayout = VFS.Include("LuaRules/Gadgets/ZeroWars/side_unit_layout.lua")
local PlatformUnitLayout = VFS.Include("LuaRules/Gadgets/ZeroWars/platform_unit_layout.lua")

local Side = {}

local spGetTeamList = Spring.GetTeamList
local spGetTeamLuaAI = Spring.GetTeamLuaAI
local spCreateUnit = Spring.CreateUnit
local spSetUnitBlocking = Spring.SetUnitBlocking
local spSetTeamResource = Spring.SetTeamResource
local spGetTeamUnits = Spring.GetTeamUnits
local spDestroyUnit = Spring.DestroyUnit
local spSetUnitPosition = Spring.SetUnitPosition

local function SpawnUnit(unitName, x, z, faceDir, playerID)
    
end

-- side : side of map "left", "right"
function Side.new(allyID, side, attackXPos)

    local playerList = spGetTeamList(allyID)
    local nullAI = -1
    local platforms = PlatformLayout.new(side)

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

    local function Deploy(side)

        local sideUnits = SideUnitLayout.new(side)
        for i = 1, #sideUnits do
            local unit = spCreateUnit(sideUnits[i].unitName, sideUnits[i].x, 10000, sideUnits[i].z, sideUnits[i].dir, nullAI)
            spSetUnitBlocking(unit, false)
        end

        local units = spGetTeamUnits(nullAI)
        spDestroyUnit(units[1], false, true)

        local platUnits = PlatformUnitLayout.new(side)
        local playerUnits = platUnits.playerUnits
        local comPos = platUnits.customParams["COMMANDER_SPAWN"]

        for i = 1, #platforms do
            for j = 1, #platforms[i].players do
                for k = 1, #playerUnits do
                    spCreateUnit(playerUnits[k].unitName, platforms[i].rect.x1 + playerUnits[k].x, 10000,
                                    platforms[i].rect.y1 + playerUnits[k].z, playerUnits[k].dir, platforms[i].players[j])
                end

                units = spGetTeamUnits(platforms[i].players[j])
                spSetUnitPosition(units[1], comPos.x, comPos.z)
            end
        end

        spSetTeamResource(nullAI, "metal", 0)
        for i = 1, #playerList do
            spSetTeamResource(playerList[i], "metal", 0)
        end
    end

    local side = {
        -- variables
        allyID = allyID,
        nullAI = nullAI,
        playerList = playerList,
        platforms = platforms,
        attackXPos = attackXPos,
        baseId = -1,
        turretId = -1,
        iterator = 0,
        
        -- functions
        Deploy = Deploy,
    }

    return side
end

return Side