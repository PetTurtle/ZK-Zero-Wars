include "constants.lua"
include "nanoaim.h.lua"

--pieces
local body, head, tail, leftWing1, rightWing1, leftWing2, rightWing2 = piece("body","head","tail","lwing1","rwing1","lwing2","rwing2")
local leftThigh, leftKnee, leftShin, leftFoot, rightThigh, rightKnee, rightShin, rightFoot = piece("lthigh", "lknee", "lshin", "lfoot", "rthigh", "rknee", "rshin", "rfoot")
local lforearml,lbladel,rforearml,rbladel,lforearmu,lbladeu,rforearmu,rbladeu = piece("lforearml", "lbladel", "rforearml", "rbladel", "lforearmu", "lbladeu", "rforearmu", "rbladeu")
local spike1, spike2, spike3, firepoint, spore1, spore2, spore3 = piece("spike1", "spike2", "spike3", "firepoint", "spore1", "spore2", "spore3")

local smokePiece = {}

local turretIndex = {
}

local bladeAngle = math.rad(140)

local jaws = {
	{forearm = lforearmu, blade = lbladeu, angle = bladeAngle},
	{forearm = lforearml, blade = lbladel, angle = bladeAngle},
	{forearm = rforearmu, blade = rbladeu, angle = -bladeAngle},
	{forearm = rforearml, blade = rbladel, angle = -bladeAngle},
}

--constants
local wingAngle = math.rad(40)
local wingSpeed = math.rad(120)
local tailAngle = math.rad(20)

local bladeExtendSpeed = math.rad(600)
local bladeRetractSpeed = math.rad(120)

function script.Create()
    Turn(rightWing1, x_axis, math.rad(15), math.rad(45))
	Turn(leftWing1, x_axis, math.rad(15), math.rad(45))
	Turn(rightWing1, z_axis, math.rad(-40), math.rad(45))
	Turn(rightWing2, z_axis, math.rad(80), math.rad(60))
	Turn(leftWing1, z_axis, math.rad(40), math.rad(45))
	Turn(leftWing2, z_axis, math.rad(-80), math.rad(60))
	EmitSfx(body, 1026)
	EmitSfx(head, 1026)
	EmitSfx(tail, 1026)
	EmitSfx(firepoint, 1026)
	EmitSfx(leftWing1, 1026)
	EmitSfx(rightWing1, 1026)
	EmitSfx(spike1, 1026)
	EmitSfx(spike2, 1026)
	EmitSfx(spike3, 1026)
	Turn(spore1, x_axis, math.rad(90))
	Turn(spore2, x_axis, math.rad(90))
	Turn(spore3, x_axis, math.rad(90))

	Spring.SetUnitNanoPieces(unitID, {head})
end

function script.StartBuilding()
	Spring.SetUnitCOBValue(unitID, COB.INBUILDSTANCE, 1);
end

function script.StopBuilding()
	Spring.SetUnitCOBValue(unitID, COB.INBUILDSTANCE, 0);
end

function script.QueryNanoPiece()
	GG.LUPS.QueryNanoPiece(unitID,unitDefID, Spring.GetUnitTeam(unitID), head)
	return head
end

function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage / maxHealth

	if severity < 0.25 then
		return 1
	elseif severity < 0.50 then
		Explode (aim, SFX.FALL)
		return 1
	elseif severity < 0.75 then
		Explode (aim, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
		return 2
	else
		Explode (body, SFX.SHATTER)
		Explode (aim, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
		return 2
	end
end