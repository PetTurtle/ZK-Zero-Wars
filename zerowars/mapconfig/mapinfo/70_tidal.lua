--------------------------------------------------------------------------------------------------------
-- Tidal settings
--------------------------------------------------------------------------------------------------------

if (Spring.GetMapOptions().tidal == "low") then
	return {
		tidalStrength = (mapinfo.tidalstrength or 5) * 0.7,
	}
elseif (Spring.GetMapOptions().tidal == "high") then
	return {
		tidalStrength = (mapinfo.tidalstrength or 5) * 1.4,
	}
end
