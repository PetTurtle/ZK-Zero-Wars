local unitTweaks = VFS.Include("gamedata/unit_tweaks.lua")

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