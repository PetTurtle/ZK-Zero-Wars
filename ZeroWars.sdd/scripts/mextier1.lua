local base, bottom, tamper, furnace, door_l, door_r, hinge_l, hinge_r, drill1, drill2, drill3, posts =
	piece(
	"base",
	"bottom",
	"tamper",
	"furnace",
	"door_l",
	"door_r",
	"hinge_l",
	"hinge_r",
	"drill1",
	"drill2",
	"drill3",
	"posts"
)

include "pieceControl.lua"
include "constants.lua"

local SIG_OPEN = 1

local smokePiece = {tamper}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function Open()
	Signal(SIG_OPEN)
	SetSignalMask(SIG_OPEN)

	Turn(hinge_r, z_axis, math.rad(-120), math.rad(120))
	Turn(hinge_l, z_axis, math.rad(120), math.rad(120))
	WaitForTurn(hinge_l, z_axis)
	Move(tamper, y_axis, 15, 10)
	WaitForMove(tamper, y_axis)

	local height = 40

	while true do
		Spin(furnace, y_axis, 3, math.rad(1))
		Spin(drill1, y_axis, 3, math.rad(1))
		Move(tamper, y_axis, height, 3 * 10)
		WaitForMove(tamper, y_axis)
		height = 60 - height
	end
end

function script.Activate()
	StartThread(Open)
end

function script.Create()
	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
	if not Spring.GetUnitIsStunned(unitID) then
		StartThread(Open)
	end
end

local explodables = {door_l, furnace}
function script.Killed(recentDamage, maxHealth)
	for i = 1, #explodables do
		Explode(explodables[i], SFX.FALL + SFX.SMOKE)
	end
	return 1
end
