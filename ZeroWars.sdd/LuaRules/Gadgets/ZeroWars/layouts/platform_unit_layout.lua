local Platform_Unit_Layout = {}

-- side : side of map "left", "right"
function Platform_Unit_Layout.new(side)

    local playerUnits = {}
    local globalUnits = {}
    local customParams = {}

    if side == "left" then

        playerUnits = {
            {unitName = "basiccon", x = 192.5, z = 350, dir = "e"},
        }

        globalUnits = {

        }

        customParams = {
            COMMANDER_SPAWN = {x = 1855, z = 1537},
        }

    elseif side == "right" then

        playerUnits = {
            {unitName = "basiccon", x = 567.5, z = 410, dir = "w"},
        }

        globalUnits = {

        }

        customParams = {
            COMMANDER_SPAWN = {x = 6336, z = 1537}
        }

    end

    local units = { 
        playerUnits = playerUnits,
        globalUnits = globalUnits,
        customParams = customParams,
    }
    return units
end

return Platform_Unit_Layout