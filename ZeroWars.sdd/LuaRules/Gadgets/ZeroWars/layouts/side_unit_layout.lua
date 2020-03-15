local Side_Unit_Layout = {}

-- side : side of map "left", "right"
function Side_Unit_Layout.new(side)

    local units = {}

    if side == "left" then
        table.insert(units, {unitName = "baseturret", x = 2496, z = 1530, dir = "e", noSelectable = false,})
        table.insert(units, {unitName = "centerturret", x = 3264, z = 1530, dir = "e", noSelectable = false,})
        table.insert(units, {unitName = "staticrearm", x = 1550, z = 1226, dir = "e", noSelectable = true,})
        table.insert(units, {unitName = "staticrearm", x = 1550, z = 1386, dir = "e", noSelectable = true,})
        table.insert(units, {unitName = "staticrearm", x = 1550, z = 1529, dir = "e", noSelectable = true,})
        table.insert(units, {unitName = "staticrearm", x = 1550, z = 1703, dir = "e", noSelectable = true,})
        table.insert(units, {unitName = "staticrearm", x = 1550, z = 1848, dir = "e", noSelectable = true,})
    elseif side == "right" then
        table.insert(units, {unitName = "baseturret", x = 5696, z = 1530, dir = "w", noSelectable = false,})
        table.insert(units, {unitName = "centerturret", x = 4930, z = 1530, dir = "w", noSelectable = false,})
        table.insert(units, {unitName = "staticrearm", x = 6641, z = 1226, dir = "w", noSelectable = true,})
        table.insert(units, {unitName = "staticrearm", x = 6641, z = 1386, dir = "w", noSelectable = true,})
        table.insert(units, {unitName = "staticrearm", x = 6641, z = 1529, dir = "w", noSelectable = true,})
        table.insert(units, {unitName = "staticrearm", x = 6641, z = 1703, dir = "w", noSelectable = true,})
        table.insert(units, {unitName = "staticrearm", x = 6641, z = 1848, dir = "w", noSelectable = true,})
    end

    return units
end

return Side_Unit_Layout