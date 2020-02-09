--------------------------------------------------------------------------------------------------------
-- Wind settings
--------------------------------------------------------------------------------------------------------

if (Spring.GetMapOptions().wind == "low") then
	return { atmosphere = {
		minWind = (mapinfo.atmosphere.minwind or 5) * 0.85,
		maxWind = (mapinfo.atmosphere.maxwind or 25) * 0.75,
	}}
elseif (Spring.GetMapOptions().wind == "high") then
	return { atmosphere = {
		minWind = (mapinfo.atmosphere.minwind or 5) * 1.2,
		maxWind = (mapinfo.atmosphere.maxwind or 25) * 1.5,
	}}
end
