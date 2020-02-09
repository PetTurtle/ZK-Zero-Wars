--------------------------------------------------------------------------------------------------------
-- MetalExtractor radius settings
--------------------------------------------------------------------------------------------------------

if (not tobool(Spring.GetMapOptions().extractorradius)) then
	return
end

return {
	extractorradius = tonumber(Spring.GetMapOptions().extractorradius),
}
