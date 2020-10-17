function widget:GetInfo()
	return {
		name = "Heroes Units",
		desc = "displays hero units stats and upgrades",
		author = "petturtle",
		date = "2020",
		license = "GNU GPL, v2 or later",
		layer = 10,
		handler = true,
		enabled = true
	}
end

include("colors.h.lua")
VFS.Include("LuaRules/Configs/constants.lua")
local HeroDefs = include("luarules/configs/hero_defs.lua")

local spGetSelectedUnits = Spring.GetSelectedUnits
local spGetUnitRulesParam = Spring.GetUnitRulesParam
local spGetUnitDefID = Spring.GetUnitDefID
local spGiveOrderToUnit = Spring.GiveOrderToUnit

local CMD_CUSTOM_UPGRADE = 49731
local CMD_HERO_CHEAT_XP = 49732
local CMD_HERO_CHEAT_Level = 49733
local activeColor = {0.5, 0.5, 0.5, 0.7}
local inactiveColor = {0.0, 0.0, 0.0, 0.0}

local Chili
local screen0
local window
local upgradeList
local upgradeButtons = {}
local levelLabel
local pointsLabel
local xpProgressbar
local cheatXPButton
local cheatLevelButton

local visible = true
local cheats = true
local heroID

local function xpForLevel(level)
    return 100*level*level + 500
end

local function CurrentModuleClick(self, path)
	spGiveOrderToUnit(heroID, CMD_CUSTOM_UPGRADE, {path}, 0)
end

local function GiveCommand(self, command)
	spGiveOrderToUnit(heroID, command, {}, 0)
end

local function CreateWindow()
	window =
		Chili.Window:New {
		name = "ZeroWarsData",
		classname = "main_window",
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
		parent = screen0
	}

	local topLabel =
		Chili.Label:New {
		x = 0,
		right = 0,
		y = 0,
		height = 35,
		valign = "center",
		align = "center",
		caption = "Upgrades",
		autosize = false,
		font = {size = 20, outline = true, color = {.8, .8, .8, .9}, outlineWidth = 2, outlineWeight = 2},
		parent = window
	}

	upgradeList =
		Chili.StackPanel:New {
		x = 3,
		right = 2,
		y = 36,
		bottom = 0,
		padding = {0, 0, 0, 0},
		itemPadding = {2, 2, 2, 2},
		itemMargin = {0, 0, 0, 0},
		backgroundColor = {1, 1, 1, 0.8},
		resizeItems = false,
		centerItems = false,
		parent = window
	}

	for i = 1, 4 do
		upgradeButtons[i] =
			Chili.Button:New {
			caption = "caption",
			font = {size = 20, outline = true, color = cyan, outlineWidth = 2, outlineWeight = 2},
			x = 0,
			y = 0,
			right = 0,
			minHeight = 55,
			height = 55,
			padding = {0, 0, 0, 0},
			backgroundColor = activeColor,
			OnClick = {},
			tooltip = "tooltip",
			parent = upgradeList,
			OnClick = {
				function(self)
					CurrentModuleClick(self, i)
				end
			}
		}
	end

	levelLabel =
		Chili.Label:New {
		x = 40,
		right = 0,
		bottom = 35,
		caption = "Level 1",
		autosize = false,
		font = {size = 16, outline = true, color = cyan, outlineWidth = 2, outlineWeight = 2},
		parent = window
	}

	pointsLabel =
		Chili.Label:New {
		x = 110,
		right = 0,
		bottom = 35,
		caption = "Points 1",
		autosize = false,
		font = {size = 16, outline = true, color = cyan, outlineWidth = 2, outlineWeight = 2},
		parent = window
	}

	xpProgressbar =
		Chili.Progressbar:New {
		x = 10,
		right = 10,
		bottom = 10,
		value = 45,
		max = 1,
		caption = "",
		parent = window
	}

	cheatXPButton =
		Chili.Button:New {
		caption = "+XP",
		font = {size = 20, outline = true, color = cyan, outlineWidth = 2, outlineWeight = 2},
		--x = 0,
		y = 0,
		right = 25,
		width = 25,
		height = 25,
		padding = {0, 0, 0, 0},
		font = {size = 8},
		backgroundColor = activeColor,
		OnClick = {},
		tooltip = "gives 100 xp",
		parent = window,
		OnClick = {
			function(self)
				GiveCommand(self, CMD_HERO_CHEAT_XP)
			end
		}
	}

	cheatLevelButton =
		Chili.Button:New {
		caption = "+Lvl",
		font = {size = 20, outline = true, color = cyan, outlineWidth = 2, outlineWeight = 2},
		--x = 0,
		y = 0,
		right = 0,
		width = 25,
		height = 25,
		padding = {0, 0, 0, 0},
		font = {size = 8},
		backgroundColor = activeColor,
		OnClick = {},
		tooltip = "adds level",
		parent = window,
		OnClick = {
			function(self)
				GiveCommand(self, CMD_HERO_CHEAT_Level)
			end
		}
	}
end

local function toggleCheats(state)
	if state and not cheats then
		cheatXPButton:SetVisibility(state)
		cheatLevelButton:SetVisibility(state)
		cheats = true
	elseif not state and cheats then
		cheatXPButton:SetVisibility(state)
		cheatLevelButton:SetVisibility(state)
		cheats = false
	end
end

local function setUpdateParams(id, params, level)
	upgradeButtons[id]:SetCaption(level .. ". " .. params.name)
	upgradeButtons[id].tooltip = params.desc
end

local function setUpdateBlocked(id, params, level)
	upgradeButtons[id].OnClick = nil
	upgradeButtons[id].backgroundColor = inactiveColor
	setUpdateParams(id, params, level)
	upgradeButtons[id]:Invalidate()
end

local function setUpdateOption(id, params, level)
	upgradeButtons[id].OnClick = {
		function(self)
			CurrentModuleClick(self, id)
		end
	}
	upgradeButtons[id].backgroundColor = activeColor
	setUpdateParams(id, params, level)
	upgradeButtons[id]:Invalidate()
end

local function setUpgradeMaxed(id)
	upgradeButtons[id].OnClick = nil
	upgradeButtons[id]:SetCaption("Max Level")
	upgradeButtons[id].tooltip = "Max Level"
	upgradeButtons[id].backgroundColor = inactiveColor
	upgradeButtons[id]:Invalidate()
end

local function UpdateUI(unitID, ud)
	heroID = unitID
	local xp = math.floor(spGetUnitRulesParam(unitID, "xp"))
	local level = spGetUnitRulesParam(unitID, "level")
	local points = spGetUnitRulesParam(unitID, "points")
	local xpNeeded = xpForLevel(level)

	levelLabel:SetCaption("Level " .. (level + 1))
	pointsLabel:SetCaption("Points " .. points)

	if level == 16 then
		xpProgressbar:SetValue(1)
		xpProgressbar:SetMinMax(0, 1)
		xpProgressbar:SetCaption("Max Level")
	else
		xpProgressbar:SetValue(xp)
		xpProgressbar:SetMinMax(0, xpNeeded)
		xpProgressbar:SetCaption(xp .. "/" .. xpNeeded)
	end

	local upgadeDefs = HeroDefs[ud.name]
	for i = 1, 4 do
		local pathLevel = spGetUnitRulesParam(unitID, "path" .. i)
		if pathLevel < 4 then
			local upgradeCount = level - points
			local requiredUpgrades = upgadeDefs["path" .. i][pathLevel + 1].requiredUpgrades
			if points > 0 and upgradeCount >= requiredUpgrades then
				setUpdateOption(i, upgadeDefs["path" .. i][pathLevel + 1], pathLevel + 1)
			else
				setUpdateBlocked(i, upgadeDefs["path" .. i][pathLevel + 1], pathLevel + 1)
			end
		else
			setUpgradeMaxed(i)
		end
	end
end

local function setVisible(value)
	if value and not visible then
		screen0:AddChild(window)
		visible = true
	elseif not value and visible then
		screen0:RemoveChild(window)
		heroID = nil
		visible = false
	end
end

function widget:Initialize()
	Chili = WG.Chili
	if (not Chili) then
		widgetHandler:RemoveWidget()
		return
	end
	screen0 = Chili.Screen0
	CreateWindow()

	setVisible(false)
	toggleCheats(Spring.IsCheatingEnabled())
end

function widget:Shutdown()
	window:Dispose()
end

function widget:GameFrame(n)
	if n % 15 == 0 and heroID then
		local ud = UnitDefs[spGetUnitDefID(heroID)]
		UpdateUI(heroID, ud)

		toggleCheats(Spring.IsCheatingEnabled())
	end
end

function widget:CommandsChanged()
	local units = spGetSelectedUnits()
	if units then
		for i = 1, #units do
			if spGetUnitRulesParam(units[i], "level") then
				local ud = UnitDefs[spGetUnitDefID(units[i])]
				UpdateUI(units[i], ud)
				setVisible(true)
				return
			end
		end
	end
	setVisible(false)

	toggleCheats(Spring.IsCheatingEnabled())
end