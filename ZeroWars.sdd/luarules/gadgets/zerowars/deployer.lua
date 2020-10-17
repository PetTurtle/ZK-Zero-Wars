VFS.Include("LuaRules/Configs/customcmds.h.lua")
local Queue = VFS.Include("luarules/gadgets/util/queue.lua")
local spawnAmount = 12
local mapCenter = Game.mapSizeX / 2

local Deployer = {}
Deployer.__index = Deployer

function Deployer.new()
    local instance = {
        spawnQueue = Queue.new(),
    }
    setmetatable(instance, Deployer)
    return instance
end

function Deployer:add(rect, targetRect, teamID, faceDir, attackX)
    local xmin, zmin = rect:getTopLeft()
    local xmax, zmax = rect:getBottomRight()
    local units = Spring.GetUnitsInRectangle(xmin, zmin, xmax, zmax, teamID)
    local unit, ud, buildProgress
    local validUnits = {}
    local unitSpeeds = {}
    for i = 1, #units do
        unit = units[i]
        ud = UnitDefs[Spring.GetUnitDefID(unit)]
        buildProgress = select(5, Spring.GetUnitHealth(unit))
        if buildProgress >= 1.0 and not (ud.isBuilding or ud.isBuilder) then
            local commands = Spring.GetCommandQueue(unit, -1)
            local speed = ud.speed
            if commands and #commands > 0 and commands[1].id == CMD.GUARD then
                local guardUnitID = commands[1].params[1]
                local guardUnitDefID = Spring.GetUnitDefID(guardUnitID)
                local guardUnitSpeed =  UnitDefs[guardUnitDefID].speed
                speed = math.min(guardUnitSpeed, speed)
			end
			
			-- provide deploy income
			if ud.customParams and ud.customParams.deploy_income then
				local deploy_income = ud.customParams.deploy_income or 0
				Spring.AddTeamResource(teamID, "metal", deploy_income)
			end
            
            unitSpeeds[#unitSpeeds + 1] = speed
            validUnits[#validUnits + 1] = unit
        end
    end
    if #validUnits > 0 then
        local offset = rect:getOffset(targetRect)
        self.spawnQueue:push({units = validUnits, offset = offset, teamID = teamID, faceDir = faceDir, attackX = attackX, unitSpeeds = unitSpeeds})
    end
end

function Deployer:deploy()
    if self.spawnQueue:size() == 0 then
        return
    end

    local group = self.spawnQueue:peek()
    local units = group.units
    local unitSpeeds = group.unitSpeeds
    local offset = group.offset
    local clone, x, y, z
    local clones = {}
    for i = #units, math.max(1, #units - spawnAmount), -1 do
        if not Spring.GetUnitIsDead(units[i]) then
            x, y, z = Spring.GetUnitPosition(units[i])
            if x then
                clone = GG.cloneUnit(units[i], x + offset.x, 300, z + offset.z, group.faceDir, group.teamID)
                clones[#clones + 1] = clone
                
                Spring.SetUnitRulesParam(clone, "clone", 1)
                Spring.SetUnitRulesParam(clone, "original", units[i])
                Spring.GiveOrderToUnit(clone, CMD_WANTED_SPEED, {unitSpeeds[i]}, 0)
                Spring.GiveOrderToUnit(
                    clone,
                    CMD.INSERT,
                    {-1, CMD.FIGHT, CMD.OPT_SHIFT, mapCenter, 128, z + offset.z},
                    {"alt"}
                )
                Spring.GiveOrderToUnit(
                    clone,
                    CMD.INSERT,
                    {-1, CMD.FIGHT, CMD.OPT_SHIFT, group.attackX, 128, z + offset.z},
                    {"alt"}
				)
				
                units[i] = nil
            end
        end
    end
    
    if #units == 0 then
        self.spawnQueue:pop()
    end

    if #clones > 0 then
        return clones
    end
end

return Deployer