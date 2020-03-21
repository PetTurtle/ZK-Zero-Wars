include "constants.lua"
include "scalecontroller.lua"

local base, torso, head = piece("base", "torso", "head")
local rthigh, rshin, rfoot, lthigh, lshin, lfoot = piece("rthigh", "rshin", "rfoot", "lthigh", "lshin", "lfoot")
local lturret, rturret, lflare, rflare = piece("lturret", "rturret", "lflare", "rflare")

local firepoints = {[0] = lflare, [1] = rflare}

local smokePiece = {torso}
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
local PACE = 2

local THIGH_FRONT_ANGLE = -math.rad(50)
local THIGH_FRONT_SPEED = math.rad(60) * PACE
local THIGH_BACK_ANGLE = math.rad(30)
local THIGH_BACK_SPEED = math.rad(60) * PACE
local SHIN_FRONT_ANGLE = math.rad(45)
local SHIN_FRONT_SPEED = math.rad(90) * PACE
local SHIN_BACK_ANGLE = math.rad(10)
local SHIN_BACK_SPEED = math.rad(90) * PACE

local ARM_FRONT_ANGLE = -math.rad(20)
local ARM_FRONT_SPEED = math.rad(22.5) * PACE
local ARM_BACK_ANGLE = math.rad(10)
local ARM_BACK_SPEED = math.rad(22.5) * PACE
local FOREARM_FRONT_ANGLE = -math.rad(40)
local FOREARM_FRONT_SPEED = math.rad(45) * PACE
local FOREARM_BACK_ANGLE = math.rad(10)
local FOREARM_BACK_SPEED = math.rad(45) * PACE

local SIG_WALK = 1
local SIG_AIM = {2, 4}
local SIG_RESTORE = 8

local unitDefID = Spring.GetUnitDefID(unitID)

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
local gun_1 = 0
local baseHP = 2000
local health_multi = 0.2
local scale_multi = 0.12
local weapon_1 = 1
local weapon_2 = 0
local weapon_3 = 0
local armour = 0

local path1 = 0
local path2 = 0
local path3 = 0
local path4 = 0

local nanoNum = 0
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

local function Walk()
	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	while true do
		--Spring.Echo("Left foot up, right foot down")
		Turn(lthigh, x_axis, math.rad(20), math.rad(120) * PACE)
		Turn(lshin, x_axis, math.rad(-60), math.rad(140) * PACE)
		Turn(lfoot, x_axis, math.rad(40), math.rad(210) * PACE)
		Turn(rthigh, x_axis, math.rad(-20), math.rad(210) * PACE)
		Turn(rshin, x_axis, math.rad(50), math.rad(210) * PACE)
		Turn(rfoot, x_axis, math.rad(-30), math.rad(210) * PACE)
		Turn(torso, z_axis, math.rad(-5), math.rad(20) * PACE)
		Turn(lthigh, z_axis, math.rad(5), math.rad(20) * PACE)
		Turn(rthigh, z_axis, math.rad(5), math.rad(420) * PACE)
		Move(torso, y_axis, 4, 9 * PACE)
		WaitForMove(torso, y_axis)
		Sleep(0) -- needed to prevent anim breaking, DO NOT REMOVE

		--Spring.Echo("Right foot middle, left foot middle")
		Turn(lthigh, x_axis, math.rad(-10), math.rad(160) * PACE)
		Turn(lshin, x_axis, math.rad(-40), math.rad(250) * PACE)
		Turn(lfoot, x_axis, math.rad(50), math.rad(140) * PACE)
		Turn(rthigh, x_axis, math.rad(40), math.rad(140) * PACE)
		Turn(rshin, x_axis, math.rad(-40), math.rad(140) * PACE)
		Turn(rfoot, x_axis, math.rad(0), math.rad(140) * PACE)
		Move(torso, y_axis, 0, 12 * PACE)
		WaitForMove(torso, y_axis)
		Sleep(0)

		--Spring.Echo("Right foot up, Left foot down")
		Turn(rthigh, x_axis, math.rad(20), math.rad(120) * PACE)
		Turn(rshin, x_axis, math.rad(-60), math.rad(140) * PACE)
		Turn(rfoot, x_axis, math.rad(40), math.rad(210) * PACE)
		Turn(lthigh, x_axis, math.rad(-20), math.rad(210) * PACE)
		Turn(lshin, x_axis, math.rad(50), math.rad(210) * PACE)
		Turn(lfoot, x_axis, math.rad(-30), math.rad(420) * PACE)
		Turn(torso, z_axis, math.rad(5), math.rad(20) * PACE)
		Turn(lthigh, z_axis, math.rad(-5), math.rad(20) * PACE)
		Turn(rthigh, z_axis, math.rad(-5), math.rad(20) * PACE)
		Move(torso, y_axis, 4, 9 * PACE)
		WaitForMove(torso, y_axis)
		Sleep(0)

		--Spring.Echo("Left foot middle, right foot middle")
		Turn(rthigh, x_axis, math.rad(-10), math.rad(160) * PACE)
		--		Turn(rknee, x_axis, math.rad(15), math.rad(135)*PACE)
		Turn(rshin, x_axis, math.rad(-40), math.rad(250) * PACE)
		Turn(rfoot, x_axis, math.rad(50), math.rad(140) * PACE)
		Turn(lthigh, x_axis, math.rad(40), math.rad(140) * PACE)
		--		Turn(lknee, x_axis, math.rad(-35), math.rad(135))
		Turn(lshin, x_axis, math.rad(-40), math.rad(140) * PACE)
		Turn(lfoot, x_axis, math.rad(0), math.rad(140) * PACE)
		Move(torso, y_axis, 0, 12 * PACE)
		WaitForMove(torso, y_axis)
		Sleep(0)
	end
end

local function Stopping()
	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	Turn(rthigh, x_axis, 0, math.rad(80) * PACE)
	Turn(rshin, x_axis, 0, math.rad(120) * PACE)
	Turn(rfoot, x_axis, 0, math.rad(80) * PACE)
	Turn(lthigh, x_axis, 0, math.rad(80) * PACE)
	Turn(lshin, x_axis, 0, math.rad(80) * PACE)
	Turn(lfoot, x_axis, 0, math.rad(80) * PACE)
	Turn(torso, z_axis, 0, math.rad(20) * PACE)
	Move(torso, y_axis, 0, 12 * PACE)
end

function script.StartMoving()
	StartThread(Walk)
end

function script.StopMoving()
	StartThread(Stopping)
end

function script.Create()
	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
	GG.SetScale(unitID, base, scaleCount)
	Spring.SetUnitNanoPieces(unitID, firepoints)
	Spring.SetUnitWeaponState(unitID, 2, "range", 0)
	Spring.SetUnitWeaponState(unitID, 3, "range", 0)
end

local function RestoreAfterDelay()
	Signal(SIG_RESTORE)
	SetSignalMask(SIG_RESTORE)
	Sleep(5000)
	Turn(head, y_axis, 0, math.rad(65))
	Turn(lturret, x_axis, 0, math.rad(47.5))
	Turn(rturret, x_axis, 0, math.rad(47.5))
end

function script.AimFromWeapon()
	return head
end

function script.AimWeapon(num, heading, pitch)
	Signal(SIG_AIM[num])
	SetSignalMask(SIG_AIM[num])
	Turn(head, y_axis, heading, math.rad(240))
	Turn(lturret, x_axis, -pitch, math.rad(120))
	Turn(rturret, x_axis, -pitch, math.rad(120))
	WaitForTurn(head, y_axis)
	WaitForTurn(lturret, x_axis)
	WaitForTurn(rturret, x_axis)
	StartThread(RestoreAfterDelay)
	return true
end

function script.QueryWeapon(num)
	if num == 1 or num == 3 then
		return firepoints[gun_1]
	end
	return head
end

function script.FireWeapon(num)
end

function LevelUp()
	local level = Spring.GetUnitRulesParam(unitID, "level")
	GG.SetScale(unitID, base, 1 + (level * scale_multi))
	if level ~= 1 then
		local newHP =  baseHP + (level - 1) * health_multi * baseHP + armour
		Spring.SetUnitMaxHealth(unitID, newHP)
		Spring.SetUnitHealth(unitID, newHP)
	end
end

local function SetWeaponDamage(unitID, weaponID, damage)
	for i = 1, 6 do
		Spring.SetUnitWeaponDamages(unitID, weaponID, i, damage)
	end
end

function Upgrade()
	local rPath1 = Spring.GetUnitRulesParam(unitID, "path1")
	local rPath2 = Spring.GetUnitRulesParam(unitID, "path2")
	local rPath3 = Spring.GetUnitRulesParam(unitID, "path3")
	local rPath4 = Spring.GetUnitRulesParam(unitID, "path4")

	if path1 ~= rPath1 then
		if rPath1 == 1 then
			Spring.SetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 80)
			Spring.SetUnitWeaponState(unitID, 1, "burst", 2)
			Spring.SetUnitWeaponState(unitID, 1, "burstRate", 0.25)
		elseif rPath1 == 2 then
			SetWeaponDamage(unitID, 1, 300)
			Spring.SetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 120)
			Spring.SetUnitWeaponState(unitID, 1, "burst", 3)
			Spring.SetUnitWeaponState(unitID, 1, "burstRate", 0.25)
		elseif rPath1 == 3 then
			SetWeaponDamage(unitID, 1, 300)
			Spring.SetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 140)
			Spring.SetUnitWeaponState(unitID, 1, "burst", 4)
			Spring.SetUnitWeaponState(unitID, 1, "burstRate", 0.1)
		elseif rPath1 == 4 then
			SetWeaponDamage(unitID, 1, 300)
			Spring.SetUnitWeaponDamages(unitID, 1, "damageAreaOfEffect", 160)
			Spring.SetUnitWeaponState(unitID, 1, "burst", 4)
			Spring.SetUnitWeaponState(unitID, 1, "burstRate", 0.1)
		end
		path1 = rPath1
	end

	if path2 ~= rPath2 then
		weapon_2 = 2
		Spring.SetUnitWeaponState(unitID, 2, "range", 450)
		if rPath2 == 1 then
			SetWeaponDamage(unitID, 2, 1000)
		elseif rPath2 == 2 then
			SetWeaponDamage(unitID, 2, 2000)
		elseif rPath2 == 3 then
			SetWeaponDamage(unitID, 2, 3000)
		elseif rPath2 == 4 then
			SetWeaponDamage(unitID, 2, 5000)
		end
		path2 = rPath2
	end

	if path3 ~= rPath3 then
		if rPath3 == 1 then
			armour = 1000
		elseif rPath3 == 2 then
			armour = 2000
		elseif rPath3 == 3 then
			armour = 3000
		elseif rPath3 == 4 then
			armour = 5000
		end

		local level = Spring.GetUnitRulesParam(unitID, "level")
		local newHP = (level - 1) * health_multi * baseHP + armour
		Spring.SetUnitMaxHealth(unitID, newHP)
		Spring.SetUnitHealth(unitID, newHP)
		path3 = rPath3
	end

	if path4 ~= rPath4 then
		weapon_3 = 3
		Spring.SetUnitWeaponState(unitID, 3, "range", 700)
		if rPath4 == 1 then
			weapon_3 = 3
		elseif rPath4 == 2 then
			Spring.SetUnitWeaponState(unitID, 3, "burst", 6)
		elseif rPath4 == 3 then
			Spring.SetUnitWeaponState(unitID, 3, "burst", 8)
			Spring.SetUnitWeaponState(unitID, 3, "burstRate", 0.15)
		elseif rPath4 == 4 then
			Spring.SetUnitWeaponState(unitID, 3, "burst", 12)
			Spring.SetUnitWeaponState(unitID, 3, "burstRate", 0.15)
		end
		path4 = rPath4
	end
end

function script.BlockShot(num, targetID)
	if num == weapon_1 or num == weapon_2 or num == weapon_3 then
		return false
	end
	return true
end

function script.Shot(num)
	gun_1 = 1 - gun_1
end

function script.StartBuilding()
	SetUnitValue(COB.INBUILDSTANCE, 1)
end

function script.StopBuilding()
	SetUnitValue(COB.INBUILDSTANCE, 0)
end

function script.QueryNanoPiece()
	nanoNum = 1 - nanoNum
	local nano = firepoints[nanoNum]
	GG.LUPS.QueryNanoPiece(unitID, unitDefID, Spring.GetUnitTeam(unitID), nano)
	return nano
end

function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage / maxHealth
	if severity <= .25 then
		Explode(lfoot, SFX.NONE)
		Explode(lshin, SFX.NONE)
		Explode(lthigh, SFX.NONE)
		Explode(rfoot, SFX.NONE)
		Explode(rshin, SFX.NONE)
		Explode(rthigh, SFX.NONE)
		Explode(torso, SFX.NONE)
		return 1
	elseif severity <= .50 then
		Explode(lfoot, SFX.FALL)
		Explode(lshin, SFX.FALL)
		Explode(lthigh, SFX.FALL)
		Explode(rfoot, SFX.FALL)
		Explode(rshin, SFX.FALL)
		Explode(rthigh, SFX.FALL)
		Explode(torso, SFX.SHATTER)
		return 1
	elseif severity <= .99 then
		Explode(lfoot, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(lshin, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(lthigh, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(rfoot, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(rshin, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(rthigh, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(torso, SFX.SHATTER)
		return 2
	else
		Explode(lfoot, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(lshin, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(lthigh, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(rfoot, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(rshin, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(rthigh, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE)
		Explode(torso, SFX.SHATTER + SFX.EXPLODE)
		return 2
	end
end
