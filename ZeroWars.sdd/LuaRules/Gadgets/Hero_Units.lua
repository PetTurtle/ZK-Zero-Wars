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

include("LuaRules/Configs/customcmds.h.lua")
local HeroUnitDefs, AllyTeamLayouts = include("LuaRules/Configs/Hero_Units_Defs.lua")
local Hero = VFS.Include("LuaRules/Gadgets/HeroUnits/Hero.lua")

local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitAllyTeam = Spring.GetUnitAllyTeam
local spGetAllyTeamList = Spring.GetAllyTeamList
local spGetUnitHealth = Spring.GetUnitHealth

local heroes = {}
local allyHeroes = {}
local allyToLayout = {}

local function isHero(unitDefID)
    local ud = UnitDefs[unitDefID]
    if ud.customParams.hero then return true end
    return false
end

local function getAllyTeamHeros(allyTeamID)
    return allyHeroes[allyTeamID]
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

    allyToLayout[allyTeamList[1]] = 1
    allyToLayout[allyTeamList[2]] = 2
    allyHeroes[allyTeamList[1]] = {}
    allyHeroes[allyTeamList[2]] = {}
end

function gadget:GameFrame(frame)
    if frame % 30 == 0 then
        for i,hero in pairs(heroes) do
            hero:update(frame)

            if hero:canRespawn(frame) then
                hero:spawn()
            end
        end
    end
end

-- com created
function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)

    if isHero(unitDefID) then
        local allyTeamID = spGetUnitAllyTeam(unitID)
        local allyLayout = AllyTeamLayouts[allyToLayout[allyTeamID]]

        local x, y, z = spGetUnitPosition(unitID)
        local hero = Hero.new(unitID, unitDefID, allyLayout.spawnPoint, {x = x, z = z})
        heroes[unitID] = hero
        allyHeroes[allyTeamID][#allyHeroes[allyTeamID] + 1] = hero
    end
end

-- give regular kill unit xp
function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerID, attackerDefID, attackerTeam)
    
    if heroes[unitID] then
        table.remove(heroes, unitID)
        return
    end

    if heroes[attackerID] then
        local allyTeamID = spGetUnitAllyTeam(attackerID)
        local x, y, z = spGetUnitPosition(unitID)
        local inRangeHeroes = getHeroesInRange(getAllyTeamHeros(allyTeamID), {x = x, z = z}, 1000)
        for i = 1, #inRangeHeroes do
            inRangeHeroes[i]:giveXP(5/#inRangeHeroes)
        end
        return
    end
end

-- manage hero kill xp
function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)

    if heroes[unitID] then
        local hp = spGetUnitHealth(unitID)
        if hp < damage then
            if attackerID and heroes[attackerID] then
                local killXP = 40 + (0.13 * heroes[unitID]:getXP())
                local allyTeamID = spGetUnitAllyTeam(attackerID)
                local x, y, z = spGetUnitPosition(unitID)
                local inRangeHeroes = getHeroesInRange(getAllyTeamHeros(allyTeamID), {x = x, z = z}, 1000)
                for i = 1, #inRangeHeroes do
                    inRangeHeroes[i]:giveXP(killXP/#inRangeHeroes)
                end
            end

            heroes[unitID]:die()
            return 0
        end
    end

    return damage
end