function widget:GetInfo()
    return {
        name = "Zero Wars GUI",
        desc = "zero-wars local gui",
        author = "petturtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true
    }
end

local cheat = true

local function DeSelectMyClones(selectedUnits)
    if cheat then return end

    local validUnits = {}
    for i = 1, #selectedUnits do
        if not Spring.GetUnitRulesParam(selectedUnits[i], "clone") then
            validUnits[#validUnits + 1] = selectedUnits[i]
        end
    end
    Spring.SelectUnitArray(validUnits)
end

function widget:CommandsChanged()
    local selectedUnits = Spring.GetSelectedUnits()
	if selectedUnits then DeSelectMyClones(selectedUnits) end
	
	cheat = Spring.IsCheatingEnabled()
end

function widget:Initialize() end
