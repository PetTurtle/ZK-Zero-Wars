function gadget:GetInfo()
    return {
        name = "Heroes",
        desc = "adds hero units",
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

VFS.Include("LuaRules/Configs/customcmds.h.lua")
local Util = VFS.Include("luarules/gadgets/util/util.lua")
local Layout = VFS.Include("luarules/configs/hero_layout.lua")
local Hero = VFS.Include("luarules/gadgets/unit_heroes/hero.lua")
local HeroTeams = VFS.Include("luarules/gadgets/unit_heroes/hero_team.lua")

-- SyncedRead
local spGetUnitHealth = Spring.GetUnitHealth
local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitAllyTeam = Spring.GetUnitAllyTeam

-- Variables

local CMD_HERO_UPGRADE = 49731
local CMD_HERO_CHEAT_XP = 49732
local CMD_HERO_CHEAT_Level = 49733
local ALLOWED_ON_DEAD_CMD = {
	CMD_HERO_UPGRADE,
	CMD_HERO_CHEAT_XP,
	CMD_HERO_CHEAT_Level
}

local heroes = {}
local heroTeams = {}

local function isHero(unitDefID)
    return UnitDefs[unitDefID].customParams.hero
end

local function onHeroKill(unitID, attackerID, attackerTeam)
    local hero =  heroes[unitID]

    if attackerID then
        local x, _, z = spGetUnitPosition(unitID)
        local killXP = hero:getKillXP()
        if heroTeams[attackerTeam] then
            heroTeams[attackerTeam]:shareXP({x = x, z = z}, killXP)
        end
    end

    local heroTeamID = spGetUnitAllyTeam(unitID)
    heroTeams[heroTeamID]:heroDied(hero)
end

local function onKill(unitID, unitDefID, attackerID)
    if attackerID then
        local attackerAllyTeam = spGetUnitAllyTeam(attackerID)
        local killXP = UnitDefs[unitDefID].metalCost
        local x, _, z = spGetUnitPosition(unitID)
        if not heroes[attackerID] then
            killXP = killXP / 2
        end

        if heroTeams[attackerAllyTeam] then
            heroTeams[attackerAllyTeam]:shareXP({x = x, z = z}, killXP)
        end
    end
end

function gadget:GamePreload()
    local allyStarts = Util.GetAllyStarts()
    allyStarts.Left = tonumber(allyStarts.Left or 0)
    allyStarts.Right = tonumber(allyStarts.Right or 0)
    heroTeams[allyStarts.Left] = HeroTeams.new(allyStarts.Left, Layout.Left)
    heroTeams[allyStarts.Right] = HeroTeams.new(allyStarts.Right, Layout.Right)
end

function gadget:GameFrame(frame)
    if frame % 30 == 0 then
        for _, team in pairs(heroTeams) do
            team:update(frame)
        end
    end
end

-------------------------------------
-- Hero upgrade command listener
-------------------------------------
function gadget:UnitCommand(unitID, unitDefID, unitTeam, cmdID, cmdParams, cmdOptions, cmdTag)
    if cmdID == CMD_HERO_UPGRADE and heroes[unitID] then
        heroes[unitID]:upgrade(unitDefID, unitTeam, "path" .. cmdParams[1])
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
end

-------------------------------------
-- Add hero when it's created
-------------------------------------
function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
    if isHero(unitDefID) then
        local allyTeamID = spGetUnitAllyTeam(unitID)
        local hero = Hero.new(unitID, unitDefID)
        heroes[unitID] = hero
        heroTeams[allyTeamID]:addHero(unitID, hero)
    end
end

function gadget:AllowUnitTransfer(unitID)
    if heroes[unitID] then
        local heroTeamID = spGetUnitAllyTeam(unitID)
        heroTeams[heroTeamID]:heroDied(heroes[unitID])
        return false
    end
    return true
end

-------------------------------------
-- Remove hero on self-destruct
-- Give attackers xp
-------------------------------------
function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerID)
    if heroes[unitID] then
        local allyTeamID = spGetUnitAllyTeam(unitID)
        heroTeams[allyTeamID]:removeHero(unitID)
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

function gadget:Initialize()
end

function gadget:GameOver()
    gadgetHandler:RemoveGadget(self)
end
