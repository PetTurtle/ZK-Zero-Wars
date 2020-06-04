local width = 384
local height = 768

local leftX = 384
local rightX = 7424

local y1 = 128
local y2 = 1152
local y3 = 2176

return {
	[0] = {
		nameLong = "Left-Lobsters",
		nameShort = "Left",
		startpoints = {
			{leftX + (width / 2), y1 + (height / 2)},
			{leftX + (width / 2), y2 + (height / 2)},
			{leftX + (width / 2), y3 + (height / 2)}
		},
		boxes = {
			{
				{leftX, y1},
				{leftX + width, y1},
				{leftX + width, y1 + height},
				{leftX, y1 + height}
			},
			{
				{leftX, y2},
				{leftX + width, y2},
				{leftX + width, y2 + height},
				{leftX, y2 + height}
			},
			{
				{leftX, y3},
				{leftX + width, y3},
				{leftX + width, y3 + height},
				{leftX, y3 + height}
			}
		}
	},
	[1] = {
		nameLong = "Right-Lobsters",
		nameShort = "Right",
		startpoints = {
			{rightX + (width / 2), y1 + (height / 2)},
			{rightX + (width / 2), y2 + (height / 2)},
			{rightX + (width / 2), y3 + (height / 2)}
		},
		boxes = {
			{
				{rightX, y1},
				{rightX + width, y1},
				{rightX + width, y1 + height},
				{rightX, y1 + height}
			},
			{
				{rightX, y2},
				{rightX + width, y2},
				{rightX + width, y2 + height},
				{rightX, y2 + height}
			},
			{
				{rightX, y3},
				{rightX + width, y3},
				{rightX + width, y3 + height},
				{rightX, y3 + height}
			}
		}
	}
}
