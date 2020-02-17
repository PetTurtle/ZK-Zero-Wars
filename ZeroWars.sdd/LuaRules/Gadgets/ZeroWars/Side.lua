local PlatformLayout = VFS.Include("LuaRules/Gadgets/ZeroWars/platform_layout.lua")
local SideUnitLayout = VFS.Include("LuaRules/Gadgets/ZeroWars/side_unit_layout.lua")
local PlatformUnitLayout = VFS.Include("LuaRules/Gadgets/ZeroWars/platform_unit_layout.lua")

local Side = {}

local spGetTeamList = Spring.GetTeamList
local spGetTeamLuaAI = Spring.GetTeamLuaAI
local spGetTeamUnits = Spring.GetTeamUnits
local spSetTeamResource = Spring.SetTeamResource

local spCreateUnit = Spring.CreateUnit
local spDestroyUnit = Spring.DestroyUnit
local spSetUnitBlocking = Spring.SetUnitBlocking
local spSetUnitPosition = Spring.SetUnitPosition

-- side : side of map "left", "right"
function Side.new(allyID, side, attackXPos)

    local playerList = spGetTeamList(allyID)
    local platforms = PlatformLayout.new(side)

    local nullAI = -1
    local hasAI = false

    -- remove nullAI from team list
    for i = #playerList, 1, -1 do
        local luaAI = spGetTeamLuaAI(playerList[i])
        if luaAI and string.find(string.lower(luaAI), "ai") then
            hasAI = true
            nullAI = playerList[i]
            table.remove(playerList, i)
        end
    end

    -- if nullAI is null, set it as player
    if nullAI == -1 and #playerList > 0 then
        nullAI = playerList[1]
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
        -- variables
        allyID = allyID,
        nullAI = nullAI,
        playerList = playerList,
        platforms = platforms,
        attackXPos = attackXPos,
        baseId = -1,
        turretId = -1,
        iterator = 0,
    }

    function side:Deploy(side)
        
        -- deploy units (or buildings) related to the side
        local sideUnits = SideUnitLayout.new(side)
        for i = 1, #sideUnits do
            local unit = spCreateUnit(sideUnits[i].unitName, sideUnits[i].x, 10000, sideUnits[i].z, sideUnits[i].dir, self.nullAI)
            spSetUnitBlocking(unit, false)

            if sideUnits[i].unitName == "baseturret" then
                self.baseId = unit
            elseif sideUnits[i].unitName == "centerturret" then
                self.turretId = unit
            end
        end

        -- remove nullAI com if nullAI exists
        if hasAI then
            local units = spGetTeamUnits(self.nullAI)
            spDestroyUnit(units[1], false, true)
        end

        -- set platform units and custom params
        local platUnits = PlatformUnitLayout.new(side)
        local playerUnits = platUnits.playerUnits
        local comPos = platUnits.customParams["COMMANDER_SPAWN"]
        for i = 1, #self.platforms do
            for j = 1, #self.platforms[i].players do
                for k = 1, #playerUnits do
                    spCreateUnit(playerUnits[k].unitName, self.platforms[i].rect.x1 + playerUnits[k].x, 10000,
                                    self.platforms[i].rect.y1 + playerUnits[k].z, playerUnits[k].dir, self.platforms[i].players[j])
                end

                units = spGetTeamUnits(self.platforms[i].players[j])
                spSetUnitPosition(units[1], comPos.x, comPos.z)
            end
        end

        -- clear team resourse
        spSetTeamResource(self.nullAI, "metal", 0)
        for i = 1, #self.playerList do
            spSetTeamResource(self.playerList[i], "metal", 0)
        end
    end

    function side:HasPlayer(playerID)
        for i = 0, #self.playerList do
            if self.playerList[i] == playerID then
                return true
            end
        end
        return false
    end

    function side:RemovePlayer(playerID)
        for i = 0, #self.playerList do
            if self.playerList[i] == playerID then
                table.remove(self.playerList, i)
                break
            end
        end

        if #self.playerList == 0 then
            -- all players resigned, end game
            spDestroyUnit(self.baseId)
        else
            -- remove player from platform
            local platID = -1
            for i = #self.platforms, 1, -1 do
                local id = self.platforms[i]:HasPlayer(playerID)
                if id then
                    table.remove(self.platforms[i],players, id)
                    platID = i
                    break
                end
            end

            -- if no players left on platform assign random player
            -- TODO: Finish
            if platID ~= -1 and #self.platforms[platID].players == 0 then
                
            end
        end
    end

    return side
end

return Side