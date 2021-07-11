function gadget:GetInfo()
    return {
        name = "Zero-Wars Mod",
        desc = "zero-k autobattler",
        author = "petturtle",
        date = "2021",
        layer = 0,
        enabled = true
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

VFS.Include("LuaRules/Configs/customcmds.h.lua")
local Util = VFS.Include("luarules/gadgets/util/util.lua")
local config = VFS.Include("luarules/configs/zwconfig.lua")

local SPAWNFRAME = 1000
local PLATFORMHEIGHT = 128
local MAPCENTER = Game.mapSizeX / 2

local bomberDefIDs = {
  [UnitDefNames["bomberassault"].id] = true,
  [UnitDefNames["bomberdisarm"].id] = true,
  [UnitDefNames["bomberheavy"].id] = true,
  [UnitDefNames["bomberprec"].id] = true,
  [UnitDefNames["bomberriot"].id] = true,
  [UnitDefNames["bomberstrike"].id] = true,
}

local sides = {}

local function InitSide(side, allyTeamID, enemyAllyTeamID)
    sides[allyTeamID] = side
    side.allyTeamID = allyTeamID
    local teams = Spring.GetTeamList(allyTeamID)

    -- set passive income
    GG.Overdrive.AddInnateIncome(allyTeamID, 3, -2)

    -- create nexus
    local nPos = side.nexus
    local nID = Spring.CreateUnit("nexus", nPos.x, 128, nPos.z, side.faceDir, teams[1])
    Spring.SetUnitBlocking(nID, false, false)
    GG.AddOnDeathEvent(nID, function ()
        Spring.GameOver({enemyAllyTeamID})
    end)

    -- create center turret
    local tPos = side.nexusTurret
    local tID = Spring.CreateUnit("nexusturret", tPos.x, 128, tPos.z, side.faceDir, teams[1])
    Spring.SetUnitBlocking(nID, false, false)
    GG.AddOnDeathEvent(tID, function ()
        local teamList = Spring.GetTeamList(enemyAllyTeamID)
        for i = 1, #teamList do
            Spring.AddTeamResource(teamList[i], "metal", 800)
        end
    end)

    -- create extra buildings
    for _, building in pairs(side.extraBuildings) do
        local unitID = Spring.CreateUnit(building.unitName, building.x, 128, building.z, side.faceDir, teams[1])
        Spring.SetUnitNoSelect(unitID, true)
        Spring.SetUnitNeutral(unitID, true)
    end
end

local function GetPlatformID(side, x, z)
    for i = 1, #side.platforms do
        local plat = side.platforms[i]
        if Util.HasRectPoint(plat.x, plat.z, plat.width, plat.height, x, z) then
            return i
        end
    end

    return -1
end

local function AddBuilder(builderID, side)
    local teamID = Spring.GetUnitTeam(builderID)
    local x, _, z = Spring.GetUnitPosition(builderID)
    local platID = GetPlatformID(side, x, z)

    if platID == -1 then
        Spring.DestroyUnit(builderID)
        return
    end

    local plat = side.platforms[platID]
    if plat.teamID == nil then
        plat.teamID = teamID
        plat.builderID = builderID
        return
    end

    -- if platform already has builder merge them together
    if plat.teamID ~= teamID then
        Util.MergeTeams(teamID, plat.teamID)
    end

    Spring.DestroyUnit(builderID, false, true)
end

function gadget:GamePreload()
    local allyStarts = Util.GetAllyStarts()
    allyStarts.Left = tonumber(allyStarts.Left or 0)
    allyStarts.Right = tonumber(allyStarts.Right or 0)
    InitSide(config.Left, allyStarts.Left, allyStarts.Right)
    InitSide(config.Right, allyStarts.Right, allyStarts.Left)
end

function gadget:GameStart()
    -- replace commanders with builders and assign them to platforms
    local builders = Util.ReplaceStartUnit("builder")
    for _, builderID in pairs(builders) do
        Spring.SetUnitRulesParam(builderID, "facplop", 1, {inlos = true})
        local allyTeamID = Spring.GetUnitAllyTeam(builderID)
        AddBuilder(builderID, sides[allyTeamID])
    end

    -- create deploy zones for each platform
    for _, side in pairs(sides) do
        local remainingPlatforms = {}

        for _, plat in pairs(side.platforms) do
            if plat.teamID ~= nil then
                Util.SetBuildMask(plat.x, plat.z, plat.width, plat.height, 2)
                remainingPlatforms[#remainingPlatforms+1] = plat
                plat.DeployZoneID = GG.DeployZones.Create(plat.x, plat.z, side.deployRect.x, side.deployRect.z, plat.width, plat.height, plat.teamID, side.faceDir, (SPAWNFRAME * 0.75)/30)
                GG.DeployZones.Blacklist(plat.DeployZoneID, plat.builderID)
            end
        end

        side.platforms = remainingPlatforms
        side.platIterator = -1
    end

    Util.SetGlobalMetalStorage(1000000)

    GG.UnitCMDBlocker.AllowCommand(1, 1)
    
    GG.UnitCMDBlocker.AppendFilter(1, function(unitID, unitDefID, cmdID, cmdParams, cmdOptions, cmdTag, synced)
      -- allow bombers to rearm
      if cmdID == 1 then
        return bomberDefIDs[unitDefID] == true and synced == -1
      end
      
      return true
    end)
end

function gadget:GameFrame(frame)
    -- spawn next wave
    if frame > 0 and frame % SPAWNFRAME == 0 then
        for _, side in pairs(sides) do
            if #side.platforms > 0 then
                side.platIterator = (side.platIterator + 1) % #side.platforms
                local plat = side.platforms[side.platIterator + 1]
                local units = GG.DeployZones.Deploy(plat.DeployZoneID)

                for i = 1, #units do
                    local unitID = units[i]
                    local x, _, z = Spring.GetUnitPosition(unitID)
                    Spring.GiveOrderToUnit(
                        unitID,
                        CMD.INSERT,
                        {-1, CMD.FIGHT, CMD.OPT_SHIFT, MAPCENTER, PLATFORMHEIGHT, z},
                        {"alt"}
                    )
                    Spring.GiveOrderToUnit(
                        unitID,
                        CMD.INSERT,
                        {-1, CMD.FIGHT, CMD.OPT_SHIFT, side.attackPosX, PLATFORMHEIGHT, z},
                        {"alt"}
                    )

                    GG.UnitCMDBlocker.AppendUnit(unitID, 1)
                    
                    GG.AddOnIdleEvent(unitID, function ()
                        local x,_, z = Spring.GetUnitPosition(unitID)
                        if math.abs(x - side.attackPosX) > 200 then
                            Spring.GiveOrderToUnit(unitID, CMD.FIGHT, {side.attackPosX, PLATFORMHEIGHT, z}, {"alt"})
                        end
                    end)
                end
            end
        end
    end
end

-- disable unit movement built on deploy zones
function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
    if builderID then
        local ud = UnitDefs[unitDefID]
        if not (ud.isBuilding or ud.isBuilder) then
            Spring.SetUnitNeutral(unitID, true)
            GG.BlockUnitMovement.Block(unitID)
        end
    end
end

-- block wreck creation
function gadget:AllowFeatureCreation(featureDefID, teamID, x, y, z)
    return false
end

function gadget:Initialize()
end

function gadget:GameOver()
    gadgetHandler:RemoveGadget(self)
end
