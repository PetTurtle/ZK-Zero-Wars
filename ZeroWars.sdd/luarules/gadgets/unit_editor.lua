function gadget:GetInfo()
    return {
        name = "Unit Editor",
        desc = "Edits Unit Stats",
        author = "PetTurtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

local units = {}
local addEffect

--- Key of Attributes is the identity of buffs, preventing overloading and repeating  
local attr_key="zerowars_unit_editor"

local function SetWeaponDamage(unitID, weaponID, damage)
    Spring.SetUnitWeaponDamages(unitID, weaponID, {damage, damage, damage, damage, damage, damage})
end

local function enableCmd(unitID, CMD, state)
    local index = Spring.FindUnitCmdDesc(unitID, CMD)
    if index then
        local cmdTable = Spring.GetUnitCmdDescs(unitID, index)
        cmdTable.disabled = not state
        cmdTable.hidden = not state
        Spring.EditUnitCmdDesc(unitID, index, cmdTable)
    end
end

local function NewEditedUnit(unitID)
    local unitdefID = Spring.GetUnitDefID(unitID)
    local weaponDefs = UnitDefs[unitdefID].weapons
    local weapons = {}
    for i = 1, #weaponDefs do
        weapons[i] = {
            ID = weaponDefs[i].weaponDef
        }
    end

    units[unitID] = {
        unitID = unitID,
        defID = unitdefID,
        weapons = weapons
    }
    return units[unitID]
end

local UnitEditor = {}

function UnitEditor.HP(unit, multiplier)
    unit.hp = (unit.hp or 1) + multiplier
    local originalHealth = UnitDefs[unit.defID].health
    local currHP, currMaxHP = Spring.GetUnitHealth(unit.unitID)
    local newMaxHP = (originalHealth * unit.hp) + (unit.armour or 0)
    local newHP = currHP * newMaxHP / currMaxHP
    Spring.SetUnitMaxHealth(unit.unitID, newMaxHP)
    Spring.SetUnitHealth(unit.unitID, newHP)
end

function UnitEditor.Armour(unit, increase)
    unit.armour = (unit.armour or 0) + increase
    local currHP, currMaxHP = Spring.GetUnitHealth(unit.unitID)
    local newMaxHP = currMaxHP + increase
    local newHP = currHP * newMaxHP / currMaxHP
    Spring.SetUnitMaxHealth(unit.unitID, newMaxHP)
    Spring.SetUnitHealth(unit.unitID, newHP)
end

function UnitEditor.Scale(unit, increase)
    unit.scale = (unit.scale or 1) + increase
    GG.UnitModelRescale(unit.unitID, unit.scale)
end

function UnitEditor.IdleRegen(unit, regenTimeMulti, regenAmountMulti)
    unit.regenTime = (unit.regenTime or 1) + regenTimeMulti
    unit.regenAmount = (unit.regenAmount or 1) + regenAmountMulti
    local original_regen = (UnitDefs[unit.defID].customParams.idle_regen or UnitDefs[unit.defID].idleAutoHeal)
    local new_regen_time = UnitDefs[unit.defID].idleTime * unit.regenTime
    local new_regen_amount = original_regen * unit.regenAmount
    GG.SetUnitIdleRegen(unit.unitID, new_regen_time, new_regen_amount)
end

local function UpdateUnitEffects(unit)
	addEffect(unit.unitID, attr_key, {
        move = unit.moveSpeed,
        turn = unit.turnSpeed or unit.accel,
        econ = unit.econ,
        build = unit.buildPower,
        sense = unit.los
    })
end

local function UpdateWeaponEffects(unit, weaponID, weapon)
    weapon = weapon or unit.weapons[weaponID]
    addEffect(unit.unitID, attr_key .. "_wpn_" .. weaponID, {
        weaponNum = weaponID,
        reload = weapon.reload,
        range = weapon.range,
		damage = GG.ATT_ENABLE_DAMAGE and weapon.damage or nil
    })
end

function UnitEditor.MoveSpeed(unit, multiplier)
    unit.moveSpeed = (unit.moveSpeed or 1) + multiplier
    UpdateUnitEffects(unit)
end

function UnitEditor.TurnSpeed(unit, multiplier)
    unit.turnSpeed = (unit.turnSpeed or 1) + multiplier
    UpdateUnitEffects(unit)
end

function UnitEditor.AccelSpeed(unit, multiplier)
    unit.accel = (unit.accel or 1) + multiplier
    UpdateUnitEffects(unit)
end

function UnitEditor.Econ(unit, multiplier)
    unit.econ = (unit.econ or 1) + multiplier
    UpdateUnitEffects(unit)
end

function UnitEditor.BuildPower(unit, multiplier)
    unit.buildPower = (unit.buildPower or 1) + multiplier
    UpdateUnitEffects(unit)
end

function UnitEditor.LOSRange(unit, multiplier)
    unit.los = (unit.los or 1) + multiplier
    UpdateUnitEffects(unit)
end

function UnitEditor.WeaponReload(unit, weaponID, multiplier)
    local weapon = unit.weapons[weaponID]
    weapon.reload = (weapon.reload or 1) + multiplier
	UpdateWeaponEffects(unit,weaponID,weapon)
end

function UnitEditor.WeaponRange(unit, weaponID, multiplier)
    local weapon = unit.weapons[weaponID]
    weapon.range = (weapon.range or 1) + multiplier
	UpdateWeaponEffects(unit,weaponID,weapon)
end

function UnitEditor.WeaponBurst(unit, weaponID, increase)
    local weapon = unit.weapons[weaponID]
    local originalBurst = WeaponDefs[weapon.ID].salvoSize
    units.burst = (units.burst or 0) + increase
    Spring.SetUnitWeaponState(unit.unitID, weaponID, "burst", originalBurst + units.burst)
end

function UnitEditor.WeaponAOE(unit, weaponID, multiplier)
    local weapon = unit.weapons[weaponID]
    weapon.AOE = (weapon.AOE or 1) + multiplier
    Spring.SetUnitWeaponDamages(unit.unitID, weaponID, "craterAreaOfEffect",
        WeaponDefs[weapon.ID].craterAreaOfEffect * weapon.AOE)
    Spring.SetUnitWeaponDamages(unit.unitID, weaponID, "damageAreaOfEffect",
        WeaponDefs[weapon.ID].damageAreaOfEffect * weapon.AOE)
end

function UnitEditor.WeaponDamage(unit, weaponID, multiplier)
	if GG.ATT_ENABLE_DAMAGE then
		local weapon = unit.weapons[weaponID]
		weapon.damage = (weapon.damage or 1) + multiplier
		UpdateWeaponEffects(unit,weaponID,weapon)
	else
		local weapon = unit.weapons[weaponID]
		local originalDamage = WeaponDefs[weapon.ID].damages[1]
		weapon.damage = (weapon.damage or 1) + multiplier
		SetWeaponDamage(unit.unitID, weaponID, originalDamage * weapon.damage)
	end
end

function UnitEditor.WeaponParalyzeTime(unit, weaponID, multiplier)
    local weapon = unit.weapons[weaponID]
    local originalParalyzeTime = WeaponDefs[weapon.ID].damages.paralyzeDamageTime
    weapon.paralyzeTime = (weapon.paralyzeTime or 1) + multiplier
    Spring.SetUnitWeaponDamages(unit.unitID, weaponID, "paralyzeDamageTime", originalParalyzeTime * weapon.paralyzeTime)
end

function UnitEditor.EnableCommand(unit, command, state)
    unit[command] = {
        block = not state
    }
    enableCmd(unit.unitID, command, state)
end

function UnitEditor.CustomParam(unit, param)
end -- TODO: Add

local function EditUnit(unitID, update, ...)
    local unit = units[unitID] or NewEditedUnit(unitID)
	UnitEditor[update](unit, ...)
	GG.UpdateUnitAttributes(unitID)
end

function gadget:AllowCommand(unitID, _, _, cmdID)
    if units[unitID] then
        local unit = units[unitID]
        if unit[cmdID] and unit[cmdID].block then
            return false
        end
    end
    return true
end

function gadget:Initialize()
    addEffect = GG.Attributes.AddEffect
    GG.EditUnit = EditUnit
end

function gadget:UnitDestroyed(unitID)
    if units[unitID] then
        table.remove(units, unitID)
    end
end
