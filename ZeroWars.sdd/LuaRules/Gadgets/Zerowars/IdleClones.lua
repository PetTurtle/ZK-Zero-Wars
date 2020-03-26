local Queue = VFS.Include("LuaRules/Gadgets/Data/Queue.lua")

local spGetUnitAllyTeam = Spring.GetUnitAllyTeam

IdleClones = {}
IdleClones.__index = IdleClones

function IdleClones.new(attackPos)
    local instance = {
        _idle = Queue.new(),
        _attackPos = attackPos 
    }
    setmetatable(instance, IdleClones)
    return instance
end

function IdleClones:add(unitID)
    self._idle:push(unitID)
end

function IdleClones:command()
    while self._idle:size() > 0 do
        local unitID = self._idle:pop()
        local allyID = spGetUnitAllyTeam(unitID)

        if not Spring.GetUnitIsDead(unitID) then
            local cQueue = Spring.GetCommandQueue(unitID, 1)
            if cQueue and #cQueue == 0 then
                local x, y, z = Spring.GetUnitPosition(unitID)
                Spring.GiveOrderToUnit(unitID, CMD.INSERT, {-1, CMD.FIGHT, CMD.OPT_SHIFT, self._attackPos[allyID], 0, z}, {"alt"})
            end
        end
    end
end

return IdleClones