function gadget:GetInfo()
	return {
		name      = "feature placer",
		desc      = "Spawns Features and Units",
		author    = "Gnome, Smoth",
		date      = "August 2008",
		license   = "PD",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

if (not gadgetHandler:IsSyncedCode()) then
  return false
end

if (Spring.GetGameFrame() >= 1) then
  return false
end

local SetUnitNeutral        = Spring.SetUnitNeutral
local SetUnitBlocking       = Spring.SetUnitBlocking
local SetUnitRotation       = Spring.SetUnitRotation
local SetUnitAlwaysVisible  = Spring.SetUnitAlwaysVisible
local CreateUnit            = Spring.CreateUnit
local CreateFeature         = Spring.CreateFeature

local featurecfg
local featureslist
local buildinglist
local unitlist


if VFS.FileExists("mapconfig/featureplacer/config.lua") then
	featurecfg = VFS.Include("mapconfig/featureplacer/config.lua")
	
	featureslist = featurecfg.objectlist
	buildinglist = featurecfg.buildinglist
	unitlist     = featurecfg.unitlist
else
	Spring.Echo("missing file")
	Spring.Echo("No features loaded")
end


if ( featurecfg ) then
	local gaiaID = Spring.GetGaiaTeamID()

	if ( featureslist ) then
		for i,fDef in pairs(featureslist) do
			local flagID = CreateFeature(fDef.name, fDef.x, Spring.GetGroundHeight(fDef.x,fDef.z)+5, fDef.z, fDef.rot)
		end
	end

	if ( unitlist ) then
		local los_status = {los=true, prevLos=true, contRadar=true, radar=true}
		for i,uDef in pairs(unitlist) do
			local flagID = CreateUnit(uDef.name, uDef.x, 0, uDef.z, 0, gaiaID)
			SetUnitRotation(flagID, 0, -uDef.rot * math.pi / 32768, 0)
			SetUnitNeutral(flagID,true)
			Spring.SetUnitLosState(flagID,0,los_status)
			SetUnitAlwaysVisible(flagID,true)
			SetUnitBlocking(flagID,true)
		end
	end

	if ( buildinglist ) then
		local los_status = {los=true, prevLos=true, contRadar=true, radar=true}
		for i,bDef in pairs(buildinglist) do
			local flagID = CreateUnit(bDef.name, bDef.x, 0, bDef.z, bDef.rot, gaiaID)
			SetUnitNeutral(flagID,true)
			Spring.SetUnitLosState(flagID,0,los_status)
			SetUnitAlwaysVisible(flagID,true)
			SetUnitBlocking(flagID,true)
		end
	end
end

return false --unload
