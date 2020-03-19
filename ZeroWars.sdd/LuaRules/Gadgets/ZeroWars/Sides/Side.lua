local Cloner = VFS.Include("LuaRules/Gadgets/ZeroWars/Sides/Platform/Cloner.lua")
local Clones = VFS.Include("LuaRules/Gadgets/ZeroWars/Sides/Platform/Clones.lua")

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
function Side:new(allyID, layout)
    local o = {}
    setmetatable(o, Side)
    o.allyID = allyID
    o.teamList = spGetTeamList(allyID)
    o.layout = layout
    o.deployRect = layout.deployRect
    o.platforms = layout.platforms
    o.attackXPos = layout.attackXPos
    o.faceDir = layout.faceDir
    o.baseId = -1
    o.turretId = -1
    o.iterator = 0
    o.cloner = Cloner:Create(o.deployRect, o.faceDir, o.attackXPos)
    o.clones = Clones:Create()

    -- assign teams to platforms
    for i = 1, #o.teamList do
        o.platforms[(i % #o.platforms) + 1]:AddTeam(o.teamList[i])
    end
    
    -- remove platforms with no teams
    for i = #o.platforms, 1, -1 do
        if not o.platforms[i]:IsActive() then
            table.remove(o.platforms, i)
        end
    end

    o.deployRect:SetBuildMask(0)
    return o
end

function Side:Deploy()
    -- deploy units (or buildings) related to the side
    local sideUnits = self.layout.buildings
    for i = 1, #sideUnits do
        local unit = spCreateUnit(sideUnits[i].unitName, sideUnits[i].x, 10000, sideUnits[i].z, sideUnits[i].dir, self.teamList[1])
        spSetUnitBlocking(unit, false)
        Spring.SetUnitNoSelect(unit, sideUnits[i].noSelectable)

        if sideUnits[i].unitName == "baseturret" then
            self.baseId = unit
        elseif sideUnits[i].unitName == "centerturret" then
            self.turretId = unit
        end
    end

    -- deploy platforms
    for i = 1, #self.platforms do
        self.platforms[i]:Deploy(self.layout.playerUnits, self.layout.customParams)
    end
end

function Side:Update(frame) 
    if self.cloner:Size() > 0 then
        local clones, originals = self.cloner:Deploy()
        self.clones:NewClones(clones, originals, frame)
    end
    self.clones:ClearTimedOut(frame)
    self.clones:CommandIdles(self.attackXPos)
end

function Side:CloneNextPlatform()
    self.iterator=((self.iterator + 1) % #self.platforms)
    self.cloner:Add(self.platforms[self.iterator + 1])
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

function Side:IsActiveClone(unitID)
    return self.clones:IsActiveClone(unitID)
end

function Side:RemoveActiveClone(unitID)
    self.clones:RemoveActiveClone(unitID)
end

function Side:AddIdleClone(unitID)
    return self.clones:AddIdle(unitID)
end

return Side