function gadget:GetInfo()
    return {
        name = "Zero-Wars Mod",
        desc = "zero-k autobattler",
        author = "petturtle",
        date = "2020",
        layer = 0,
        enabled = true
    }
end

if (not gadgetHandler:IsSyncedCode()) then
    return false
end

local Map = VFS.Include("luarules/gadgets/util/map.lua")
local Side = VFS.Include("luarules/gadgets/zerowars/side.lua")
local Deployer = VFS.Include("luarules/gadgets/zerowars/deployer.lua")
local platforms, deployRects, buildings, sideData  = VFS.Include("luarules/configs/map_zerowars.lua")

local SPAWNFRAME = 800

local sides = {}
local deployData = {}

local map = Map.new()
local deployer = Deployer.new()

local function GenerateSides()
    local allyStarts = map:getAllyStarts()
    allyStarts.Left = tonumber(allyStarts.Left or 0)
    allyStarts.Right = tonumber(allyStarts.Right or 0)
    sides[allyStarts.Left] = Side.new(allyStarts.Left,  platforms.Left, deployRects.Left, buildings.Left)
    sides[allyStarts.Right] = Side.new(allyStarts.Right, platforms.Right, deployRects.Right, buildings.Right)
    deployData[allyStarts.Left] = sideData.Left
    deployData[allyStarts.Right] = sideData.Right
end

local function NextWave()
    for allyTeam, side in pairs(sides) do
        if side:hasPlatforms() then
            local platform = side:nextPlatform()
            for _, builderID in pairs(platform.builders) do
                local teamID = Spring.GetUnitTeam(builderID)
                local eIncome = Spring.GetTeamRulesParam(teamID, "OD_team_energyIncome") or 0
                Spring.SetTeamResource(teamID, "metal", eIncome)

                local data = deployData[allyTeam]
                deployer:add(platform.deployZone, data.deployRect, teamID, data.faceDir, data.attackX)
            end
        end
    end
end

function gadget:GamePreload()
    GenerateSides()
end

function gadget:GameStart()
    local builders = map:replaceStartUnit("builder")
    map:setMetalStorage(300)

    for _, builderID in pairs(builders) do
        local allyTeamID = Spring.GetUnitAllyTeam(builderID)
        sides[allyTeamID]:addBuilder(builderID)
    end

    for _, side in pairs(sides) do
        side:removedUnusedPlatforms()
    end
end

function gadget:GameFrame(frame)
    if frame > 0 and frame % SPAWNFRAME == 0 then
        NextWave()
    end
    deployer:deploy()
end

-- transfer clone experience to original
function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    if Spring.GetUnitRulesParam(unitID, "clone") then
        local original = Spring.GetUnitRulesParam(unitID, "original")
        if original and not Spring.GetUnitIsDead(original) then
            Spring.SetUnitExperience(original, Spring.GetUnitExperience(unitID))
            return
        end
    end
end

-- disallow wreck creation
function gadget:AllowFeatureCreation(featureDefID, teamID, x, y, z)
    return false
end

function gadget:Initialize()
end

function gadget:GameOver()
    gadgetHandler:RemoveGadget(self)
end
