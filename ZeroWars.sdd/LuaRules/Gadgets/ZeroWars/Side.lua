local PlatformLayout = VFS.Include("LuaRules/Gadgets/ZeroWars/layouts/platform_layout.lua")
local SideUnitLayout = VFS.Include("LuaRules/Gadgets/ZeroWars/layouts/side_unit_layout.lua")
local PlatformUnitLayout = VFS.Include("LuaRules/Gadgets/ZeroWars/layouts/platform_unit_layout.lua")

local spGetTeamList = Spring.GetTeamList
local spGetTeamLuaAI = Spring.GetTeamLuaAI
local spGetTeamUnits = Spring.GetTeamUnits
local spSetTeamResource = Spring.SetTeamResource

local spCreateUnit = Spring.CreateUnit
local spDestroyUnit = Spring.DestroyUnit
local spSetUnitBlocking = Spring.SetUnitBlocking
local spSetUnitPosition = Spring.SetUnitPosition

Side = {}
Side.__index = Side

-- side : side of map "left", "right"
function Side:new(allyID, side, attackXPos)
    local o = {}
    setmetatable(o, Side)

    local playerList = spGetTeamList(allyID)
    local platformlayout = PlatformLayout.new(side)
    local platforms = platformlayout.platforms

    local nullAI = -1
    local hasAI = false

    -- remove nullAI from team list
    for i = #playerList, 1, -1 do
        local luaAI = spGetTeamLuaAI(playerList[i])
        if luaAI and string.find(string.lower(luaAI), "ai") then
            hasAI = true
            nullAI = playerList[i]
            table.remove(playerList, i)
            break
        end
    end

    -- if nullAI is null, set it as player
    if nullAI == -1 and #playerList > 0 then
        nullAI = playerList[1]
    end

    -- assign players to platforms
    for i = 1, #playerList do
        platforms[(i % #platforms) + 1]:AddPlayer(playerList[i])
    end

    -- remove platforms with no players
    for i = #platforms, 1, -1 do
        if #platforms[i].playerList == 0 then
            table.remove(platforms, i)
        end
    end

    -- set buildMasks
    platformlayout.deployPlatform:SetBuildMask(0)
    for i = 1, #platforms do
        platforms[i].rect:SetOutlineBuildMask(0)
    end

    o.hasAI = hasAI
    o.allyID = allyID
    o.nullAI = nullAI
    o.playerList = playerList
    o.deployRect = platformlayout.deployPlatform
    o.platforms = platforms
    o.attackXPos = attackXPos
    o.baseId = -1
    o.turretId = -1
    o.iterator = 0
    return o
end

function Side:Deploy(side)
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
    if self.hasAI then
        local units = spGetTeamUnits(self.nullAI)
        spDestroyUnit(units[1], false, true)
    end

    -- deploy platforms
    local platUnits = PlatformUnitLayout.new(side)
    for i = 1, #self.platforms do
        self.platforms[i]:Deploy(platUnits)
    end

    -- clear team resourse
    spSetTeamResource(self.nullAI, "metal", 0)
    for i = 1, #self.playerList do
        spSetTeamResource(self.playerList[i], "metal", 0)
    end
end

function Side:HasPlayer(playerID)
    for i = 0, #self.playerList do
        if self.playerList[i] == playerID then
            return true
        end
    end
    return false
end

function Side:RemovePlayer(playerID)
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
        -- remove resigned player from platforms
        local platID = -1
        for i = #self.platforms, 1, -1 do
            local id = self.platforms[i]:HasPlayer(playerID)
            if id then
                table.remove(self.platforms[i].playerList, id)
                platID = i
                break
            end
        end

        if platID ~= -1 and #self.platforms[platID].playerList == 0 then
            table.remove(self.platforms, platID)
        end
    end
end

return Side