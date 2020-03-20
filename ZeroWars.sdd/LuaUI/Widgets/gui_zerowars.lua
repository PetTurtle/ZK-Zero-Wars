function widget:GetInfo() return {
	name      = "Zero Wars GUI",
	desc      = "zero-wars local gui",
	author    = "petturtle",
	date      = "2020",
	license   = "GNU GPL, v2 or later",
	layer     = 10,
	handler   = true,
	enabled   = true,
} end

VFS.Include("LuaRules/Configs/customcmds.h.lua")

local validCommands = {
    CMD.FIRE_STATE,
    CMD.MOVE_STATE,
    CMD.REPEAT,
    CMD.CLOAK,
    CMD.ONOFF,
    CMD.TRAJECTORY,
    CMD_UNIT_AI = true,
    CMD_AIR_STRAFE,
    CMD_PUSH_PULL,
    CMD_AP_FLY_STATE,
    CMD_UNIT_BOMBER_DIVE_STATE,
    CMD_AP_FLY_STATE,
}

function widget:Initialize()
	Chili = WG.Chili
	if (not Chili) then widgetHandler:RemoveWidget() return end
end