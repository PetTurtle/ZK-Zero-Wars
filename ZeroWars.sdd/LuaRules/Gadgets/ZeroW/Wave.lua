local Wave = {}

function Wave.new(units, spawnFrame)
    local wave = {
        units = units,
        spawnFrame = spawnFrame
    }

    return wave
end

return Wave