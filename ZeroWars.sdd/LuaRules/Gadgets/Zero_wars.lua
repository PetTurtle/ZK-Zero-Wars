function gadget:GetInfo()
    return {
        name = "Zero Wars",
        desc = "zero wars",
        author = "petturtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 1,
        enabled = true,
        handler = true
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

-----------------------------------------
-----------------------------------------

local Side = VFS.Include("LuaRules/Gadgets/Zerowars/Side.lua")
local Deployer = VFS.Include("LuaRules/Gadgets/Zerowars/Deployer.lua")
local CloneTimeout = VFS.Include("LuaRules/Gadgets/Zerowars/CloneTimeout.lua")
local IdleClones = VFS.Include("LuaRules/Gadgets/Zerowars/IdleClones.lua")
local Layout = VFS.Include("LuaRules/Gadgets/Zerowars/Layout.lua")

local spGameOver = Spring.GameOver
local spDestroyUnit = Spring.DestroyUnit
local spSetTeamResource = Spring.SetTeamResource
local spSetUnitNeutral = Spring.SetUnitNeutral
local spAddTeamResource = Spring.AddTeamResource
local spSetUnitExperience = Spring.SetUnitExperience

local spGetAllUnits = Spring.GetAllUnits
local spGetTeamList = Spring.GetTeamList
local spGetUnitDefID = Spring.GetUnitDefID
local spGetUnitIsDead = Spring.GetUnitIsDead
local spGetAllyTeamList = Spring.GetAllyTeamList
local spGetUnitRulesParam = Spring.GetUnitRulesParam
local spGetUnitExperience = Spring.GetUnitExperience

local SPAWNFRAME = 800
local UPDATEFRAME = 30

local gameStarted = false
local sides = {}
local controlPoints = {}
local deployer
local cloneTimeout
local idleClones

local function onStart()
    sides[1]:onStart(Layout[1].buildings, Layout[1].playerUnits, Layout[1].platfromBuildings)
    sides[2]:onStart(Layout[2].buildings, Layout[2].playerUnits, Layout[2].platfromBuildings)

    -- End Game When Side 1's Base Dies
    GG.AddOnDeathEvent(sides[1]._baseID,
    function ()
        spGameOver({sides[2]._allyID})
    end)

    -- End Game When Side 2's Base Dies
    GG.AddOnDeathEvent(sides[2]._baseID,
    function ()
        spGameOver({sides[1]._allyID})
    end)

    -- Reward Side 2 for killing turret
    GG.AddOnDeathEvent(sides[1]._turretID,
    function ()
        local teamList = spGetTeamList(sides[2]._allyID)
        for j = 1, #teamList do
            spAddTeamResource(teamList[j], "metal", 800)
        end
    end)

    -- Reward Side 1 for killing turret
    GG.AddOnDeathEvent(sides[2]._turretID,
    function ()
        local teamList = spGetTeamList(sides[1]._allyID)
        for j = 1, #teamList do
            spAddTeamResource(teamList[j], "metal", 800)
        end
    end)

    -- Clear resources
    for i, allyTeam in pairs(spGetAllyTeamList()) do
        for j, team in pairs(spGetTeamList(allyTeam)) do
            spSetTeamResource(team, "metal", 0)
        end
    end

    -- remove default commanders
    for i, unit in pairs(spGetAllUnits()) do
        local ud = UnitDefs[spGetUnitDefID(unit)]
        if ud.customParams.commtype then
            spDestroyUnit(unit, false, true)
        end
    end

    -- Create ControlPoints
    GG.createControlPoint(4095, 128, 1535, 3)
    -- controlPoints[1] = ControlPoint.new({x = 4095, y = 128, z = 1535}, 3)

    gameStarted = true
end

function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end
    -- require two ally teams
    local allyTeamList = spGetAllyTeamList()
    if #allyTeamList < 3 then
        gadgetHandler:RemoveGadget()
        return
    end

    sides[1] = Side.new(allyTeamList[1], Layout[1].platforms)
    sides[2] = Side.new(allyTeamList[2], Layout[2].platforms)

    deployer = Deployer.new()
    cloneTimeout = CloneTimeout.new()
    idleClones = IdleClones.new({[allyTeamList[1]] = Layout[1].attackXPos, [allyTeamList[2]] = Layout[2].attackXPos})
end

function gadget:GameFrame(frame)
    if not gameStarted then
        if frame == 2 then
            onStart()
        end
        return
    end

    if frame > 0 and frame % SPAWNFRAME == 0 then
        -- deploy next platform
        for i = 1, #sides do
            sides[i]:nextPlatform()
            deployer:add(
                sides[i]:getUnits(),
                sides[i]:getOffset(Layout[i].deployRect),
                Layout[i].faceDir,
                Layout[i].attackXPos
            )
        end
    end

    if frame > 0 and frame % UPDATEFRAME == 0 then
        cloneTimeout:clear(frame)
        idleClones:command()

        for i, controlPoint in pairs(controlPoints) do
            controlPoint:update()
        end
    end

    -- spawn deploy Queue units
    if deployer:size() > 0 then
        cloneTimeout:add(deployer:deploy(), frame)
    end
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
    -- disable unit movement built by builders ( not spawned )
    -- so platform units build to be cloned can't be controlled
    if builderID then
        local ud = UnitDefs[unitDefID]
        if not (ud.isBuilding or ud.isBuilder) then
            spSetUnitNeutral(unitID, true)
            Spring.MoveCtrl.Enable(unitID, false)
        end
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerID, attackerDefID, attackerTeam)
    if gameStarted then
        return
    end

    -- transfer clone experience to original
    if spGetUnitRulesParam(unitID, "clone") then
        local original = spGetUnitRulesParam(unitID, "original")
        if original and not spGetUnitIsDead(original) then
            spSetUnitExperience(original, spGetUnitExperience(unitID))
            return
        end
    end
end

function gadget:UnitIdle(unitID, unitDefID, unitTeam)
    if spGetUnitRulesParam(unitID, "clone") then
        idleClones:add(unitID)
    end
end

-- disallow wreck creation
function gadget:AllowFeatureCreation(featureDefID, teamID, x, y, z)
    return false
end

function gadget:TeamDied(teamID)
    local allyID = select(6, Spring.GetTeamInfo(teamID))
    if sides[1]:getAllyID() == allyID then
        sides[1]:removeTeam(teamID)
    elseif sides[2]:getAllyID() == allyID then
        sides[2]:removeTeam(teamID)
    end
end
