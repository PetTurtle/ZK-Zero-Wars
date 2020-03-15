-- Set chicken cost
for name, ud in pairs(UnitDefs) do
    if (ud.unitname:sub(1,7) == "chicken") then
        ud.buildcostmetal = ud.buildtime
        ud.buildcostenergy = ud.buildtime
    end
	if (ud.unitname == "basiccon") then
		ud.buildoptions[#ud.buildoptions + 1] = [[factorychicken]]
    end
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