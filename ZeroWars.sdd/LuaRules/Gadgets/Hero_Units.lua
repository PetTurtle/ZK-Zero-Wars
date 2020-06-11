function gadget:GetInfo()
    return {
        name = "Unit Commanders",
        desc = "unit commanders",
        author = "petturtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true,
        handler = true
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

----------------------------------------
-- Synced
----------------------------------------

include("LuaRules/Configs/customcmds.h.lua")
local Layout = VFS.Include("LuaRules/Gadgets/HeroUnits/Layout.lua")
local Side = VFS.Include("LuaRules/Gadgets/HeroUnits/Side.lua")
local Hero = VFS.Include("LuaRules/Gadgets/HeroUnits/Hero.lua")

-- SyncedCtrl
local spCreateUnit = Spring.CreateUnit
local spEditUnitCmdDesc = Spring.EditUnitCmdDesc

-- SyncedRead
local spGetTeamList = Spring.GetTeamList
local spGetPlayerList = Spring.GetPlayerList
local spGetUnitHealth = Spring.GetUnitHealth
local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitAllyTeam = Spring.GetUnitAllyTeam
local spGetAllyTeamList = Spring.GetAllyTeamList
local spFindUnitCmdDesc = Spring.FindUnitCmdDesc
local spGetUnitCmdDescs = Spring.GetUnitCmdDescs

-- Variables

local CMD_HERO_UPGRADE = 49731
local CMD_HERO_CHEAT_XP = 49732
local CMD_HERO_CHEAT_Level = 49733

local heroes = {}
local sides = {}

local function isHero(unitDefID)
    return UnitDefs[unitDefID].customParams.hero
end

local function getHeroesInRange(heroes, cPos, radius)
    local inRange = {}
    for i = 1, #heroes do
        local hPos = heroes[i]:getPosition()
        if math.sqrt(math.pow(cPos.x - hPos.x, 2) + math.pow(cPos.z - hPos.z, 2)) <= radius then
            inRange[#inRange + 1] = heroes[i]
        end
    end
    return inRange
end

local function onHeroKill(unitID, attackerID, attackerTeam)
    local hero =  heroes[unitID]

    if attackerID then
        local x, y, z = spGetUnitPosition(unitID)
        local killXP = hero:getKillXP()
        sides[attackerTeam]:shareXP({x = x, z = z}, killXP)
    end

    local heroTeamID = spGetUnitAllyTeam(unitID)
    sides[heroTeamID]:heroDied(hero)
end

local function onKill(unitID, unitDefID, attackerID, attackerTeam)
    if attackerID then
        local attackerAllyTeam = spGetUnitAllyTeam(attackerID)
        local killXP = UnitDefs[unitDefID].metalCost
        local x, y, z = spGetUnitPosition(unitID)
        if not heroes[attackerID] then
            killXP = killXP / 2
        end

        sides[attackerAllyTeam]:shareXP({x = x, z = z}, killXP)
    end
end

local function onStart()
    -- Create Hero Morph Drone
    for i, side in pairs(sides) do
        local allyTeamID = side:getAllyTeamID()
        local layout = side:getLayout()
        local droneParams = layout.droneParams
        local teamList = spGetTeamList(allyTeamID)
        for j, teamID in pairs(teamList) do
            spCreateUnit(droneParams.name, droneParams.x, droneParams.y, droneParams.z, droneParams.faceDir, teamID)
        end
    end
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

    sides[allyTeamList[1]] = Side.new(allyTeamList[1], Layout[1])
    sides[allyTeamList[2]] = Side.new(allyTeamList[2], Layout[2])
end

function gadget:GameFrame(frame)
    if frame == 2 then
        onStart()
    end

    if frame % 30 == 0 then
        for i, side in pairs(sides) do
            side:update(frame)
        end
    end
end

-------------------------------------
-- Hero upgrade command listener
-------------------------------------
function gadget:AllowCommand(unitID, unitDefID, unitTeam, cmdID, cmdParams, cmdOptions, cmdTag)
    if cmdID == CMD_HERO_UPGRADE and heroes[unitID] then
        heroes[unitID]:upgrade(unitDefID, unitTeam, "path" .. cmdParams[1])
        return true
    end

    if Spring.IsCheatingEnabled() then
        if cmdID == CMD_HERO_CHEAT_XP and heroes[unitID] then
            heroes[unitID]:giveXP(100)
        elseif cmdID == CMD_HERO_CHEAT_Level and heroes[unitID] then
            local level = heroes[unitID]:getLevel()
            local xpNeeded = 100*level*level + 500
            heroes[unitID]:giveXP(xpNeeded)
        end
    end

    return true
end

-------------------------------------
-- Add hero when it's created
-------------------------------------
function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
    if isHero(unitDefID) then
        local allyTeamID = spGetUnitAllyTeam(unitID)
        local hero = Hero.new(unitID, unitDefID)
        heroes[unitID] = hero
        sides[allyTeamID]:addHero(unitID, hero)
        GG.UnitUncapturable(unitID)

        -- disables manual fire
        local manualFireIndex = spFindUnitCmdDesc(unitID, CMD.MANUALFIRE)
        if manualFireIndex then
            local cmdTable = spGetUnitCmdDescs(unitID, manualFireIndex)
            --cmdTable.hidden = true
            cmdTable.disabled = true
            spEditUnitCmdDesc(unitID, manualFireIndex, cmdTable)
        end
        -- disables jump
        local jumpIndex = spFindUnitCmdDesc(unitID, CMD_JUMP)
        if jumpIndex then
            local cmdTable = spGetUnitCmdDescs(unitID, jumpIndex)
            cmdTable.disabled = true
            spEditUnitCmdDesc(unitID, jumpIndex, cmdTable)
        end
    end
end

-------------------------------------
-- Remove hero on self-destruct
-- Give attackers xp
-------------------------------------
function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerID)
    if heroes[unitID] then
        local allyTeamID = spGetUnitAllyTeam(unitID)
        sides[allyTeamID]:removeHero(unitID)
        table.remove(heroes, unitID)
        return
    end

    onKill(unitID, unitDefID, attackerID)
end

-------------------------------------
-- Teleport hero when it's about to die
-- Give attackers xp on hero kill
-------------------------------------
function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponID, attackerID)
    if heroes[unitID] and not paralyzer then
        local heroHP = spGetUnitHealth(unitID)
        if heroHP <= damage then
            if attackerID then -- attackerID not gauranteed
                local attackerTeam = spGetUnitAllyTeam(attackerID) or nil
                onHeroKill(unitID, attackerTeam, attackerTeam)
            end
            return 0, 0
        end
    end

    return damage
end
