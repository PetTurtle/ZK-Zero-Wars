local unitTweaks = VFS.Include("gamedata/unit_tweaks.lua")
local unitEnergy = VFS.Include("gamedata/unit_energy.lua")

UnitDefs["factoryship"] = UnitDefs["factorychicken"]

for name, ud in pairs(UnitDefs) do
	-- set chicken cost
    if (ud.unitname:sub(1,7) == "chicken") then
        ud.buildcostmetal = ud.buildtime
        ud.buildcostenergy = ud.buildtime
	end
	
	-- removed friendly fire collisions
	ud.avoidFriendly = false
	ud.collideFriendly = false
	ud.collideFirebase = false
end

for name, ud in pairs(UnitDefs) do
	-- remove friendly fire damage
	if ud.weapondefs then
		if (ud.unitname ~= "chicken_dodo") then
			for _, wd in pairs(ud.weapondefs) do
				if not wd.customparams then
					wd.customparams = { nofriendlyfire=1 }
				else
					wd.customparams.nofriendlyfire = 1
				end
			end
		end
	end
	-- set unit buildmast to 2
	if not (ud.builder or ud.isBuilder) then
		ud.buildingMask = 2
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