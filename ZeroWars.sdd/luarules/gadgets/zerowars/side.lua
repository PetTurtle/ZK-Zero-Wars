local Rect = VFS.Include("luarules/gadgets/util/rect.lua")
local Platform = VFS.Include("luarules/gadgets/zerowars/platform.lua")

local Side = {}
Side.__index = Side

function Side.new(_allyTeamID, _enemyAllyID, sideConfig)

  local dRect = sideConfig.deployRect
  local plats = sideConfig.platforms

  local instance = {
    allyTeamID = _allyTeamID or 0,
    teams = Spring.GetTeamList(_allyTeamID),
    deployRect = Rect.new(dRect.x, dRect.z, dRect.width, dRect.height),
    platforms = {
      Platform.new(Rect.new(plats[1].x, plats[1].z, plats[1].width, plats[1].height)),
      Platform.new(Rect.new(plats[2].x, plats[2].z, plats[2].width, plats[2].height)),
      Platform.new(Rect.new(plats[3].x, plats[3].z, plats[3].width, plats[3].height)),
    },
    iterator = 0
  }
  setmetatable(instance, Side)

	GG.Overdrive.AddInnateIncome(instance.allyTeamID, 3, -2)
  
  -- Create Nexus
  local nexusPos = sideConfig.nexus
  local nexusID = Spring.CreateUnit("nexus", nexusPos.x, 128, nexusPos.z, sideConfig.faceDir, instance.teams[1])
  Spring.SetUnitBlocking(nexusID, false, false)
  GG.AddOnDeathEvent(nexusID, function()
    Spring.GameOver({_enemyAllyID})
  end)

  -- Create Nexus Turret
  local turretPos = sideConfig.nexusTurret
  local turretID = Spring.CreateUnit("nexusturret", turretPos.x, 128, turretPos.z, sideConfig.faceDir, instance.teams[1])
  Spring.SetUnitBlocking(turretID, false, false)
  GG.AddOnDeathEvent(turretID, function()
    local teamList = Spring.GetTeamList(_enemyAllyID)
    for i = 1, #teamList do
      Spring.AddTeamResource(teamList[i], "metal", 800)
    end
  end)

  -- Create Extra Buildings
  for _, building in pairs(sideConfig.extraBuildings) do
    local unitID = Spring.CreateUnit(building.unitName, building.x, 128, building.z, sideConfig.faceDir, instance.teams[1])
    Spring.SetUnitNoSelect(unitID, true)
    Spring.SetUnitNeutral(unitID, true)
  end

  return instance
end

function Side:addBuilder(builderID)
    local x, y, z = Spring.GetUnitPosition(builderID)
    for _, platform in pairs(self.platforms) do
        if platform.deployZone:hasPoint(x, z) then
            platform:addBuilder(builderID)
            return
        end
    end
end

function Side:removedUnusedPlatforms()
    local remaining = {}
    for _, platform in pairs(self.platforms) do
        if platform:hasActiveBuilder() then
            remaining[#remaining + 1] = platform
        end
    end
    self.platforms = remaining
end

function Side:nextPlatform()
    self.iterator = ((self.iterator + 1) % #self.platforms)
    return self.platforms[self.iterator + 1]
end

function Side:hasPlatforms()
    return #self.platforms > 0
end

return Side
