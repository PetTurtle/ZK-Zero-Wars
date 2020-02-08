--------------------------------------------------------------------------------------------------------
-- Inverted Heightmap
--------------------------------------------------------------------------------------------------------

if (not tobool(Spring.GetMapOptions().inv)) then
	return
end

if mapinfo.smf.minheight and mapinfo.smf.maxheight then
	local min,max = mapinfo.smf.minheight, mapinfo.smf.maxheight
	mapinfo.smf.minheight = max
	mapinfo.smf.maxheight = min
else
	Spring.Echo("Error mapinfo.lua: InvertedHeightmap selected but smf.minheight and/or smf.maxheight are unset!")
end
