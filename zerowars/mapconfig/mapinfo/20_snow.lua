--------------------------------------------------------------------------------------------------------
-- Snow settings
--------------------------------------------------------------------------------------------------------

if (Spring.GetMapOptions().weather ~= "snow") then
	return
end

local cfg = {
	atmosphere = {
		skyColor     = {0.0, 0.0, 0.1},
		cloudColor   = {0.5, 0.5, 0.6},
		clouddensity = 0.8,

		fogStart     = 0.2,
		fogEnd       = 0.45,
		fogColor     = {0.8, 0.85, 0.95},
	},

	grass = {
		bladeColor  = {0.6, 1, 0.8},
	},

	custom = {
		fog = {
			color = {0.8, 0.85, 0.95},
		},

		precipitation = {
			density   = 30000,
			size      = 1.5,
			speed     = 50,
			windscale = 1.2,
			texture   = 'LuaGaia/effects/snowflake.png',
		},
	},
}

if (tobool(Spring.GetMapOptions().fog)) then
	cfg.atmosphere.fogStart = 0.4
	cfg.atmosphere.fogEnd   = 0.85
end

return cfg