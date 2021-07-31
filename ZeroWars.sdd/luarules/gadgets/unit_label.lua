function gadget:GetInfo()
    return {
        name = "Unit Label",
        desc = "draws label on unit",
        author = "petturtle",
        date = "2021",
        license = "GNU GPL, v2 or later",
        layer = -9,
        enabled = true,
    }
end

if gadgetHandler:IsSyncedCode() then

local spGetUnitTeam = Spring.GetUnitTeam
local spGetUnitHeight =  Spring.GetUnitHeight
local spGetUnitPieceList = Spring.GetUnitPieceList
local spGetUnitPieceMap = Spring.GetUnitPieceMap
local spGetUnitPieceInfo = Spring.GetUnitPieceInfo
local spGetUnitPieceMatrix = Spring.GetUnitPieceMatrix

local NULL_PIECE = "[null]"

local labels = {}

local externalFunctions = {}

local function FindBase(unitID)
    local pieces = spGetUnitPieceList(unitID)
    local pieceMap = spGetUnitPieceMap(unitID)
    for i = 1, #pieces do
        if spGetUnitPieceInfo(unitID, pieceMap[pieces[i]]).parent == NULL_PIECE then
            return pieceMap[pieces[i]]
        end
    end
end

externalFunctions.Set = function(unitID, text, size, offset)
    local scale = 1
    local base = FindBase(unitID)
    local baseHeight = spGetUnitHeight(unitID)

    if base then
        scale = spGetUnitPieceMatrix(unitID, base)
        Spring.Echo(scale)
    end

    labels[unitID] = {
        text = text,
        teamID = spGetUnitTeam(unitID),
        size = size,
        height = (baseHeight * scale) + offset
    }
end

externalFunctions.Clear = function(unitID)
    labels[unitID] = nil
end

function gadget:Initialize()
    _G.labels = labels

    GG.UnitLabel = externalFunctions
end

else -- ----- Unsynced -----


local spIsUnitVisible      = Spring.IsUnitVisible
local spGetLocalTeamID     = Spring.GetLocalTeamID
local spGetSpectatingState = Spring.GetSpectatingState
local spGetTeamColor       = Spring.GetTeamColor

local glColor             = gl.Color
local glTranslate         = gl.Translate
local glBillboard         = gl.Billboard
local glDrawFuncAtUnit    = gl.DrawFuncAtUnit

local glDepthTest      = gl.DepthTest
local glAlphaTest      = gl.AlphaTest
local GL_GREATER       = GL.GREATER

local font	= "LuaUI/Fonts/FreeSansBold_16"

local SYNCED = SYNCED
local CallAsTeam = CallAsTeam
local teamColors = {}

local function getLocalReadTeam()
    local _, specFullView = spGetSpectatingState()
    if specFullView then
        return Script.ALL_ACCESS_TEAM
    end
    return spGetLocalTeamID()
end

local function SetTeamColor(teamID)
	local r, g, b = spGetTeamColor(teamID)
	if (r and g and b) then
		teamColors[teamID] = {r, g, b}
    else
        teamColors[teamID] = {1, 1, 1}
    end
end

local function DrawLabel(unitID, label)
    glTranslate(0, label.height, 0 )
    glBillboard()

    if not teamColors[label.teamID] then
        SetTeamColor(label.teamID)
    end
    glColor(teamColors[label.teamID])
    gl.Text(label.text, 0, 0, label.size, "oc")
    glColor(1,1,1,1)
end

local function DrawLabels()
    if Spring.IsGUIHidden() then
        return
    end

    glDepthTest(true)
    glAlphaTest(GL_GREATER, 0)

    for unitID, label in pairs(SYNCED.labels) do
        if spIsUnitVisible(unitID) then
            glDrawFuncAtUnit(unitID, false, DrawLabel, unitID, label)
        end
    end

    glAlphaTest(false)
    glDepthTest(false)
end

function gadget:DrawWorld()
	CallAsTeam({['read'] = getLocalReadTeam()}, DrawLabels)
end

function gadget:DrawWorldRefraction()
	CallAsTeam({['read'] = getLocalReadTeam()}, DrawLabels)
end

end
