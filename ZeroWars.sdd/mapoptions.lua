----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
-- File:        MapOptions.lua
-- Description: Custom MapOptions file that makes possible to set up variable options before game starts, like ModOptions.lua
-- Author:      SirArtturi, Lurker, Smoth, jK
----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
--	NOTES:
--	- using an enumerated table lets you specify the options order
--
--	These keywords must be lowercase for LuaParser to read them.
--
--	key:			the string used in the script.txt
--	name:		 the displayed name
--	desc:		 the description (could be used as a tooltip)
--	type:		 the option type
--	def:			the default value
--	min:			minimum value for number options
--	max:			maximum value for number options
--	step:		 quantization step, aligned to the def value
--	maxlen:	 the maximum string length for string options
--	items:		array of item strings for list options
--	scope:		'all', 'player', 'team', 'allyteam'			<<< not supported yet >>>
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local options = {
--// Sections
	{
		key  = 'Atmosphere',
		name = 'Atmosphere Settings',
		desc = 'Weather and time',
		type = 'section',
	},

	{
		key  = 'Terrain',
		name = 'Terrain Settings',
		desc = '',
		type = 'section',
	},

	{
		key  = 'Economy',
		name = 'Economy Settings',
		desc = '',
		type = 'section',
	},

--// Options
	--// Atmosphere
	{
		key  = "timeofday",
		name = "Time of day",
		desc = "Night or day?",
		type = "list",
		def  = "day",
		section = 'Atmosphere',
		items = {
			{ key = "dawn",  name = "Dawn",  desc = "Day Time" },
			{ key = "day",   name = "Day",   desc = "Day Time" },
			{ key = "night", name = "Night", desc = "Night Time" }
		},
	},
	
	{
		key  = 'fog',
		name = 'Fog',
		desc = "covers the map under a gray mist (can be slow on older hardware)",
		type = 'bool',
		section = 'Atmosphere',
		def  = true,
	},
	
	{
		key  = "weather",
		name = "Weather conditions",
		desc = "snowing",
		type = "list",
		def  = "clear",
		section = 'Atmosphere',
		items = {
			{ key = "clear", name = "Clear", desc = "no weather" },
			{ key = "snow", name = "Snowing", desc = "snowy day" }
		},
	},

	--// Terrain
	{
		key = 'inv',
		name = 'Inverted Heightmap',
		desc = "flip world",
		type = 'bool',
		section = 'Terrain',
		def = false,
	},

	--// Economy
	{
		key  = 'metal',
		name = 'Metal Production',
		desc = 'Metal production levels - How much metal is produced per second',
		type = 'list',
		section = 'Economy',
		def  = 'normal',
		items	= {
			{ key = 'low', name = "Low", desc = "Low metal density - for smaller teams" },
			{ key = 'normal', name = "Normal", desc = "Default metal density" },
			{ key = 'high', name = "High", desc = "High metal density - for big teams" },
		},
	},

	{
		key   = 'wind',
		name  = 'Wind Speed',
		desc  = 'How strong wind will blow',
		type  = 'list',
		section = 'Economy',
		def   = 'normal',
		items = {
			{ key = 'low', name = "Low", desc = "Weak wind speed - for smaller teams" },
			{ key = 'normal', name = "Normal", desc = "Default wind speed" },
			{ key = 'high', name = "High", desc = "High wind speed - for big teams" },
		},
	},

	{
		key  = 'tidal',
		name = 'Tidal Strength',
		desc = 'Tidal energy levels - How much energy is produced via tidal generators',
		type = 'list',
		section = 'Economy',
		def  = 'normal',
		items = {
			{ key = 'low', name = "Low", desc = "Weak tidals - for smaller teams" },
			{ key = 'normal', name = "Normal", desc = "Default tidals" },
			{ key = 'high', name = "High", desc = "Strong tidals - for big teams" },
		},
	},
	
	{
		key     = 'extractorradius',
		name    = 'Extractor Radius',
		desc    = 'Sets the metal extractor radius',
		type    = 'number',
		section = 'Economy',
		def     = 100,
		min     = 1,
		max     = 10000,
		step    = 1,
	},
}

return options