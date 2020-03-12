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

    local teamList = spGetTeamList(allyID)
    local platformlayout = PlatformLayout.new(side)
    local platforms = platformlayout.platforms

    local nullAI = -1
    local hasAI = false

    -- remove nullAI team from team list
    for i = #teamList, 1, -1 do
        local luaAI = spGetTeamLuaAI(teamList[i])
        if luaAI and string.find(string.lower(luaAI), "ai") then
            hasAI = true
            nullAI = teamList[i]
            table.remove(teamList, i)
            break
        end
    end

    -- if nullAI team is null, set it to player team
    if nullAI == -1 and #teamList > 0 then
        nullAI = teamList[1]
    end

    -- assign teams to platforms
    for i = 1, #teamList do
        platforms[(i % #platforms) + 1]:AddTeam(teamList[i])
    end

    -- remove platforms with no teams
    for i = #platforms, 1, -1 do
        if not platforms[i]:IsActive() then
            table.remove(platforms, i)
        end
    end

    platformlayout.deployPlatform:SetBuildMask(0)

    o.hasAI = hasAI
    o.allyID = allyID
    o.nullAI = nullAI
    o.teamList = teamList
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

    -- deploy platforms
    local platUnits = PlatformUnitLayout.new(side)
    for i = 1, #self.platforms do
        self.platforms[i]:Deploy(platUnits)
    end
end

function Side:HasTeam(teamID)
    for i = 0, #self.teamList do
        if self.teamList[i] == teamID then
            return true
        end
    end
    return false
end

function Side:RemoveTeam(teamID)
    for i = 0, #self.teamList do
        if self.teamList[i] == teamID then
            table.remove(self.teamList, i)
            break
        end
    end

    if #self.teamList == 0 then
        -- all players resigned, end game
        spDestroyUnit(self.baseId)
    else
        -- remove resigned player from platforms
        local platID = -1
        for i = #self.platforms, 1, -1 do
            local id = self.platforms[i]:HasTeam(teamID)
            if id then
                self.platforms[i]:RemoveTeam(id)
                platID = i
                break
            end
        end

        if platID ~= -1 and not platforms[i]:IsActive() then
            table.remove(self.platforms, platID)
        end
    end
end

return Side