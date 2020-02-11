local Side = {}

function Side.new(team, plats, attackXPos)
    local side = {
        team = team,
        plats = plats,
        attackXPos = attackXPos,
        baseId = -1,
        turretId = -1,
        iterator = 0
    }
    return side
end

return Side