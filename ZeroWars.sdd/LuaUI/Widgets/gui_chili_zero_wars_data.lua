
function widget:GetInfo() return {
	name      = "Zero Wars Data Display",
	desc      = "displays zero wars data.",
	author    = "petturtle",
	date      = "2020",
	license   = "GNU GPL, v2 or later",
	layer     = 10,
	handler   = true,
	enabled   = true,
} end

include("colors.h.lua")
VFS.Include("LuaRules/Configs/constants.lua")

local Chili
local screen0
local window = nil
local upgradeList = nil
local levelLabel = nil
local pointsLabel = nil
local xpProgressbar = nil
local windowShown = false
local comID;

local function CreateWindow()
	window = Chili.Window:New {
		name = "ZeroWarsData",
		x = 0,
		y = 0,
		width = 201,
		height = 332,
		minWidth = 201,
		minHeight = 332,
		color = {1, 1, 1, 0.5},
		backgroundColor = {0, 0, 0, 0},
		padding = {0, 0, 0, 0},
		dockable = true,
		draggable = true,
		resizable = false,
		tweakDraggable = true,
		tweakDraggable = false,
		minimizanle = false,
		parent = screen0,
	}

	windowShown = true;

	local topLabel = Chili.Label:New{
		x      = 0,
		right  = 0,
		y      = 0,
		height = 35,
		valign = "center",
		align  = "center",
		caption = "Upgrades",
		autosize = false,
		font   = {size = 20, outline = true, color = {.8,.8,.8,.9}, outlineWidth = 2, outlineWeight = 2},
		parent = window,
	}

	upgradeList = Chili.StackPanel:New{
		x = 3,
		right = 2,
		y = 36,
		bottom = 0,
		padding = {0, 0, 0, 0},
		itemPadding = {2,2,2,2},
		itemMargin  = {0,0,0,0},
		backgroundColor = {1, 1, 1, 0.8},
		resizeItems = false,
		centerItems = false,
		parent = window,
	}

	levelLabel = Chili.Label:New{
		x      = 40,
		right  = 0,
		bottom  = 35,
		caption = "Level 1",
		autosize = false,
		font     = {size = 16, outline = true, color = cyan, outlineWidth = 2, outlineWeight = 2},
		parent = window,
	}

	pointsLabel = Chili.Label:New{
		x      = 110,
		right  = 0,
		bottom  = 35,
		caption = "Points 1",
		autosize = false,
		font     = {size = 16, outline = true, color = cyan, outlineWidth = 2, outlineWeight = 2},
		parent = window,
	}

	xpProgressbar = Chili.Progressbar:New{
		x = 3,
		right = 0,
		bottom  = 10,
		value = 45,
		max = 1,
		caption = "",
		parent = window,
	}
end

local function AddUpgradeButton(name, tooltip)
	local newButton = Chili.Button:New{
		caption = "",
		x = 0,
		y = 0,
		right = 0,
		minHeight = 55,
		height = 55,
		padding = {0, 0, 0, 0},
		backgroundColor = {0.5,0.5,0.5,0.5},
		OnClick = {},
		tooltip = tooltip,
		parent = upgradeList,
	}

	-- Image:New{
	-- 	x = 0,
	-- 	y = 0,
	-- 	bottom = 0,
	-- 	keepAspect = true,
	-- 	file = moduleData.image,
	-- 	parent = newButton,
	-- }

	local textBox = Chili.TextBox:New{
		x      = 64,
		y      = 10,
		right  = 8,
		bottom = 8,
		valign = "left",
		text   = name,
		font   = {size = 16, outline = true, color = moduleTextColor, outlineWidth = 2, outlineWeight = 2},
		parent = newButton,
	}
end

local function HideWindow()
	if windowShown then
		screen0:RemoveChild(window)
		windowShown = false
	end
end

local function ShowWindow()
	if not windowShown then
		if window then
			screen0:AddChild(window)
			windowShown = true
		else
			CreateWindow()
			AddUpgradeButton("Upgrade 1", "upgrade1")
			AddUpgradeButton("Upgrade 2", "upgrade2")
			AddUpgradeButton("Upgrade 3", "upgrade3")
			AddUpgradeButton("Upgrade 4", "upgrade4")
		end
	end
end

function widget:Initialize()
	Chili = WG.Chili
	if (not Chili) then widgetHandler:RemoveWidget() return end
	screen0 = Chili.Screen0
	CreateWindow()
	AddUpgradeButton("Upgrade 1", "upgrade1")
	AddUpgradeButton("Upgrade 2", "upgrade2")
	AddUpgradeButton("Upgrade 3", "upgrade3")
	AddUpgradeButton("Upgrade 4", "upgrade4")
	HideWindow()
end

function widget:Shutdown()
	window:Dispose()
end

function widget:CommandNotify(cmdID, cmdParams, cmdOptions)
	-- update ui if com selected
	-- local units = Spring.GetSelectedUnits()
	-- if units and #units > 0 then
	-- 	ShowWindow()
	-- else
	-- 	HideWindow()
	-- end
end

local cachedSelectedUnits
function widget:SelectionChanged(selectedUnits)
	cachedSelectedUnits = selectedUnits
end

function widget:CommandsChanged()
	local units = cachedSelectedUnits or Spring.GetSelectedUnits()
	if units and #units > 0 then
		local foundCom = false
		for i = 1, #units do
			local ud = UnitDefs[Spring.GetUnitDefID(units[i])]
			if (ud.customParams.customcom) then
				foundCom = true;
				comID = units[i]
				xpProgressbar:SetValue(Spring.GetUnitExperience(comID))
				break;
			end
		end
		if (foundCom) then
			ShowWindow()
		end
	else
		HideWindow()
	end
end