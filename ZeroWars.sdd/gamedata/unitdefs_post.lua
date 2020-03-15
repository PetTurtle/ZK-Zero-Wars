local unitTweaks = VFS.Include("gamedata/unit_tweaks.lua")

for name, ud in pairs(UnitDefs) do
	-- Add Chicken Factory
    if (ud.unitname:sub(1,7) == "chicken") then
        ud.buildcostmetal = ud.buildtime
        ud.buildcostenergy = ud.buildtime
    end
	if (ud.unitname == "basiccon") then
		ud.buildoptions[#ud.buildoptions + 1] = [[factorychicken]]
	end
	
	-- Removed Friendly Fire Collisions
	ud.avoidFriendly = false
	ud.collideFriendly = false
	ud.collideFirebase = false
end

for name, ud in pairs(UnitDefs) do
	if ud.weapondefs then
		for _, wd in pairs(ud.weapondefs) do
			if not wd.customparams then
				wd.customparams = { nofriendlyfire=1 }
			else
				wd.customparams.nofriendlyfire = 1
			end
		end
	end
end

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