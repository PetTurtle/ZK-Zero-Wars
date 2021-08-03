function gadget:GetInfo()
    return {
        name = "Control Points",
        desc = "handles control points",
        author = "petturtle",
        date = "2021",
        layer = 0,
        enabled = true
    }
end

if gadgetHandler:IsSyncedCode() then


local spGetTeamInfo = Spring.GetTeamInfo
local spGetTeamList = Spring.GetTeamList
local spGetUnitTeam = Spring.GetUnitTeam
local spGetGaiaTeamID = Spring.GetGaiaTeamID
local spAreTeamsAllied = Spring.AreTeamsAllied
local spGetUnitsInCyli = Spring.GetUnitsInCylinder
local spGetUnitsInRect = Spring.GetUnitsInRectangle

local spAddTeamResource = Spring.AddTeamResource

local UPDATEFRAME = 30

local gaiaTeamID = -1
local controlPoints = {}

local function updateControlPoint(point)
    local units = point.getUnits()

    local teamUnits = {}
    for i = 1, #units do
        local unitID = units[i]
        local unitTeamID = spGetUnitTeam(unitID)
        if teamUnits[unitTeamID] then
            teamUnits[unitTeamID] = teamUnits[unitTeamID] + 1
        else
            teamUnits[unitTeamID] = 1
        end
    end

    local defCount = 0
    local attCount = 0
    local attTeams = {}
    for teamID, count in pairs(teamUnits) do
        if spAreTeamsAllied(teamID, point.teamID) then
            defCount = defCount + count
        else
            attCount = attCount + count
            attTeams[#attTeams + 1] = teamID
        end
    end

    if defCount == 0 and attCount > 0 then
        if #attTeams == 1 or spAreTeamsAllied(unpack(attTeams)) then
            point.teamID = attTeams[1]
            Spring.Echo("Changed Teams")
        end
    end

    if not (point.teamID == gaiaTeamID) then
        local allyTeamID = select(6, spGetTeamInfo(point.teamID))
        local teamList = spGetTeamList(allyTeamID)
        for i = 1, #teamList do
            spAddTeamResource(teamList[i], "metal", point.metalIncome)
        end
    end
end


function gadget:GameFrame(frame)
    if frame % UPDATEFRAME == 0 then
        for i = 1, #controlPoints do
            updateControlPoint(controlPoints[i])
        end
    end
end

local externalFunctions = {}

externalFunctions.CreateRect = function(x, z, width, height, metalIncome)
    local getUnits = function () return spGetUnitsInRect(x, z, x + width, z + height) end
    controlPoints[#controlPoints + 1] = {
        x = x,
        z = z,
        width = width,
        height = height,
        getUnits = getUnits,
        metalIncome = metalIncome,
        teamID = gaiaTeamID
    }
end

externalFunctions.CreateCircle = function(x, z, radius, metalIncome)
    local getUnits = function () return spGetUnitsInCyli(x, z, radius) end
    controlPoints[#controlPoints + 1] = {
        x = x,
        z = z,
        radius = radius,
        getUnits = getUnits,
        metalIncome = metalIncome,
        teamID = gaiaTeamID
    }
end

function gadget:Initialize()
    gaiaTeamID = spGetGaiaTeamID()

    _G.controlPoints = controlPoints

    GG.ControlPoints = externalFunctions
end


else -- ----- Unsynced -----

local spIsGUIHidden = Spring.IsGUIHidden
local spGetTeamColor = Spring.GetTeamColor
local spGetGroundHeight = Spring.GetGroundHeight

local glText = gl.Text
local glColor = gl.Color
local glBlending = gl.Blending
local glDepthTest = gl.DepthTest
local glDrawGroundQuad = gl.DrawGroundQuad
local glDrawGroundCircle = gl.DrawGroundCircle

local glPushMatrix = gl.PushMatrix
local glTranslate = gl.Translate
local glRotate = gl.Rotate
local glPopMatrix = gl.PopMatrix

local SYNCED = SYNCED

local function SetTeamColor(teamID, alpha)
	local r, g, b = spGetTeamColor(teamID)
	if (r and g and b) then
        glColor({r, g, b, alpha})
    else
        glColor({1, 1, 1, alpha})
    end
end

local function DrawText(point)
    local textHeight = 40
    local textX = point.x + (point.width * 0.5)
    local textZ = point.z + (point.height * 0.5) + (textHeight * 0.25)
    local textY = spGetGroundHeight(textX, textZ) + 1

    glPushMatrix()
	glTranslate(textX, textY, textZ)
	glRotate(-90, 1, 0, 0)

    SetTeamColor(point.teamID, 1)
    glText("+" .. point.metalIncome, 0, 0, textHeight, "cv")
    glPopMatrix()
end

local function DrawRect(point)
    glPushMatrix()
    glTranslate(0, 0.5, 0)
    SetTeamColor(point.teamID, 0.2)
    glDrawGroundQuad(point.x, point.z, point.x + point.width, point.z + point.height, false, -0.5, -0.5, 0.5, 0.5)
    glPopMatrix()

    DrawText(point)
end

local function DrawCircle(point)
    SetTeamColor(point.teamID, 0.2)
    glDrawGroundCircle(point.x, 128, point.z, point.radius, 32)

    DrawText(point)
end

function gadget:DrawWorld()
	if spIsGUIHidden() then
		return
	end

	glDepthTest(true)
	glBlending(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
    gl.LineWidth(6.0)

    for i = 1, #SYNCED.controlPoints do
        local point = SYNCED.controlPoints[i]
        if point.radius then
            DrawCircle(point)
        else
            DrawRect(point)
        end
    end

    glColor(1,1,1,1)
	glDepthTest(true)
end

end
