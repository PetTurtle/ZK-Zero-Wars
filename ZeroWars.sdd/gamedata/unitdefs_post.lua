-- Set chicken cost
-- for name, ud in pairs(UnitDefs) do
--     if (ud.unitname:sub(1,7) == "chicken") then
--         ud.buildcostmetal = ud.buildtime
--         ud.buildcostenergy = ud.buildtime
--     end
--     if (ud.unitname == "factorychicken") then
--         ud.buildoptions = {
--             [[factorychicken]],
--         }
--     end
-- end

for _, ud in pairs(UnitDefs) do
	if ud.weaponDefs then
	    for _, wd in  pairs(ud.weaponDefs) do
			if not wd.customparams then
				wd.customparams = { nofriendlyfire=1 }
			else
				wd.customparams.nofriendlyfire = 1
			end
		end
	end
end