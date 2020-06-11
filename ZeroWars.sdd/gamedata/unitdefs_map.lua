local unitTweaks = VFS.Include("gamedata/unit_tweaks.lua")
local unitEnergy = VFS.Include("gamedata/unit_energy.lua")

UnitDefs["factoryship"] = UnitDefs["factorychicken"]

-- apply unitTweaks
if unitTweaks and type(unitTweaks) == "table" then
	Spring.Echo("Loading custom units tweaks for zero-wars")
	for name, ud in pairs(UnitDefs) do
		if unitTweaks[name] then
			Spring.Echo("Loading custom units tweaks for " .. name)
			Spring.Utilities.OverwriteTableInplace(ud, lowerkeys(unitTweaks[name]), true)
		end
	end
end

-- apply unitEnergy
if unitEnergy and type(unitEnergy) == "table" then
	Spring.Echo("Loading custom units energy for zero-wars")
	for name, ud in pairs(UnitDefs) do
		if unitEnergy[name] then
			Spring.Echo("Loading custom units energy for " .. name)
			Spring.Utilities.OverwriteTableInplace(ud, lowerkeys(unitEnergy[name]), true)
		end
	end
end