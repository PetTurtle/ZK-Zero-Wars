local Platform = VFS.Include("luarules/gadgets/zerowars/platform.lua")

local Side = {}
Side.__index = Side

function Side.new(_allyTeamID, _enemyAllyID, _platformRects, _deployRect, _buildings) 
    local instance = {
        allyTeamID = _allyTeamID or 0,
        teams = Spring.GetTeamList(_allyTeamID),
        deployRect = _deployRect,
        platforms = {
            Platform.new(_platformRects[1]),
            Platform.new(_platformRects[2]),
            Platform.new(_platformRects[3])
        },
        iterator = 0
    }
    setmetatable(instance, Side)

	GG.Overdrive.AddInnateIncome(instance.allyTeamID, 3, -2)

    for _, building in pairs(_buildings) do
        local unitID = Spring.CreateUnit(building.unitName, building.x, 128, building.z, building.dir, instance.teams[1])
        Spring.SetUnitNoSelect(unitID, building.noSelectable or false)
        Spring.SetUnitNeutral(unitID, building.neutral or false)

        if building.notBlocking then
            Spring.SetUnitBlocking(unitID, false, false)
        end

        if building.endGame then
            GG.AddOnDeathEvent(unitID, function()
                Spring.GameOver({_enemyAllyID})
            end)
        end

        if building.killReward then
            GG.AddOnDeathEvent(unitID, function()
                local teamList = Spring.GetTeamList(_enemyAllyID)
                for i = 1, #teamList do
                    Spring.AddTeamResource(teamList[i], "metal", 800)
                end
            end)
        end
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

function Side:provideIncome()
    for i = 1, #self.platforms do
        local platform = self.platforms[i]
        for _, builderID in pairs(platform.builders) do
			local teamID = Spring.GetUnitTeam(builderID)
			local team_income = Spring.GetTeamRulesParam(teamID, "deploy_income") or 0
            Spring.AddTeamResource(teamID, "metal", team_income)
        end
    end
end

return Side
