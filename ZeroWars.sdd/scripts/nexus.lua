include "constants.lua"
include "pieceControl.lua"
include "aimPosTerraform.lua"

local ActuatorBase = piece("ActuatorBase")
local ActuatorBase_1 = piece("ActuatorBase_1")
local ActuatorBase_2 = piece("ActuatorBase_2")
local ActuatorBase_3 = piece("ActuatorBase_3")
local ActuatorBase_4 = piece("ActuatorBase_4")
local ActuatorBase_5 = piece("ActuatorBase_5")
local ActuatorBase_6 = piece("ActuatorBase_6")
local ActuatorBase_7 = piece("ActuatorBase_7")
local ActuatorMiddle = piece("ActuatorMiddle")
local ActuatorMiddle_1 = piece("ActuatorMiddle_1")
local ActuatorMiddle_2 = piece("ActuatorMiddle_2")
local ActuatorMiddle_3 = piece("ActuatorMiddle_3")
local ActuatorMiddle_4 = piece("ActuatorMiddle_4")
local ActuatorMiddle_5 = piece("ActuatorMiddle_5")
local ActuatorMiddle_6 = piece("ActuatorMiddle_6")
local ActuatorMiddle_7 = piece("ActuatorMiddle_7")
local ActuatorTip = piece("ActuatorTip")
local ActuatorTip_1 = piece("ActuatorTip_1")
local ActuatorTip_2 = piece("ActuatorTip_2")
local ActuatorTip_3 = piece("ActuatorTip_3")
local ActuatorTip_4 = piece("ActuatorTip_4")
local ActuatorTip_5 = piece("ActuatorTip_5")
local ActuatorTip_6 = piece("ActuatorTip_6")
local ActuatorTip_7 = piece("ActuatorTip_7")

local Basis = piece("Basis")
local Dock = piece("Dock")
local Dock_1 = piece("Dock_1")
local Dock_2 = piece("Dock_2")
local Dock_3 = piece("Dock_3")
local Dock_4 = piece("Dock_4")
local Dock_5 = piece("Dock_5")
local Dock_6 = piece("Dock_6")
local Dock_7 = piece("Dock_7")
local Emitter = piece("Emitter")
local EmitterMuzzle = piece("EmitterMuzzle")

-- these are satellite pieces
local LimbA1 = piece("LimbA1")
local LimbA2 = piece("LimbA2")
local LimbB1 = piece("LimbB1")
local LimbB2 = piece("LimbB2")
local LimbC1 = piece("LimbC1")
local LimbC2 = piece("LimbC2")
local LimbD1 = piece("LimbD1")
local LimbD2 = piece("LimbD2")
local Satellite = piece("Satellite")
local SatelliteMuzzle = piece("SatelliteMuzzle")
local SatelliteMount = piece("SatelliteMount")

local LongSpikes = piece("LongSpikes")
local LowerCoil = piece("LowerCoil")

local ShortSpikes = piece("ShortSpikes")
local UpperCoil = piece("UpperCoil")

local DocksClockwise = {Dock, Dock_1, Dock_2, Dock_3}
local DocksCounterClockwise = {Dock_4, Dock_5, Dock_6, Dock_7}
local ActuatorBaseClockwise = {ActuatorBase, ActuatorBase_1, ActuatorBase_2, ActuatorBase_3}
local ActuatorBaseCCW = {ActuatorBase_4, ActuatorBase_5, ActuatorBase_6, ActuatorBase_7}
local ActuatorMidCW = {ActuatorMiddle, ActuatorMiddle_1, ActuatorMiddle_2, ActuatorMiddle_3}
local ActuatorMidCCW = {ActuatorMiddle_4, ActuatorMiddle_5, ActuatorMiddle_6, ActuatorMiddle_7}
local ActuatorTipCW = {ActuatorTip, ActuatorTip_1, ActuatorTip_2, ActuatorTip_3}
local ActuatorTipCCW = {ActuatorTip_4, ActuatorTip_5, ActuatorTip_6, ActuatorTip_7}

local InnerLimbs = {LimbA1, LimbB1, LimbC1, LimbD1}
local OuterLimbs = {LimbA2, LimbB2, LimbC2, LimbD2}

local smokePiece = {
    Basis,
    ActuatorBase,
    ActuatorBase_1,
    ActuatorBase_2,
    ActuatorBase_3,
    ActuatorBase_4,
    ActuatorBase_5,
    ActuatorBase_6,
    ActuatorBase_7
}

local TURN_SPEED = math.rad(200)

local isStunned = false

-- Signal definitions
local SIG_AIM = 2
local SIG_DOCK = 4

local function RestoreAfterDelay()
    Sleep(2000)
    for i = 1, 4 do
        Turn(InnerLimbs[i], y_axis, math.rad(-85), 1)
        Turn(OuterLimbs[i], y_axis, math.rad(-85), 1)
    end
    Spin(SatelliteMount, z_axis, 1, 0.5)
    Move(SatelliteMount, z_axis, 0, 30)
end

local function Animate()
    Spin(UpperCoil, z_axis, 10, 0.5)
    Spin(LowerCoil, z_axis, 10, 0.5)

    Move(ShortSpikes, z_axis, 0, 1)
    Move(LongSpikes, z_axis, 0, 1.5)
end

function script.Create()
    local ud = UnitDefs[unitDefID]
    local midTable = ud.model

    local midpos = {midTable.midx, midTable.midy, midTable.midz}
    local aimpos = {midTable.midx, midTable.midy + 15, midTable.midz}

    GG.SetupAimPosTerraform(unitID, unitDefID, midpos, aimpos, midTable.midy + 15, midTable.midy + 60, 15, 48)
    StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
    StartThread(Animate)
    StartThread(RestoreAfterDelay)
end

function script.QueryWeapon(num)
    if num == 1 then
        return SatelliteMuzzle
    else
        return EmitterMuzzle
    end
end
function script.AimFromWeapon(num)
    return SatelliteMuzzle
end

local function StunThread()
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)
    disarmed = true
end

local function UnstunThread()
    disarmed = false
    SetSignalMask(SIG_AIM)
    RestoreAfterDelay()
end

function script.AimWeapon(num, heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    while firing or disarmed do
        Sleep(34)
    end

    for i = 1, 4 do
        Turn(InnerLimbs[i], y_axis, math.rad(-20), 1)
        Turn(OuterLimbs[i], y_axis, math.rad(-20), 1)
    end
    Spin(SatelliteMount, z_axis, 10, 2)
    Move(SatelliteMount, z_axis, 200, 30 * 4)

    StartThread(RestoreAfterDelay)
    return true
end

function script.FireWeapon(num)
    firing = true
    EmitSfx(SatelliteMount, GG.Script.UNIT_SFX2)
    Sleep(800)
    firing = false
end

function script.BlockShot(num, targetID)
    -- Block for less than full damage and time because the target may dodge.
    return (targetID and
        (GG.DontFireRadar_CheckBlock(unitID, targetID) or GG.OverkillPrevention_CheckBlock(unitID, targetID, 680.1, 18))) or
        false
end

function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if (severity <= 0.25) then
        Explode(Basis, SFX.NONE)
        return 1 -- corpsetype
    elseif (severity <= 0.5) then
        Explode(Basis, SFX.NONE)
        return 1 -- corpsetype
    else
        Explode(Basis, SFX.SHATTER)
        return 2 -- corpsetype
    end
end
