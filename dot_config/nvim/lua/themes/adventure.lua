---@type Base46Table
local M = {}

M.base_30 = {
	white = "#feffff",
	black = "#040404",
	darker_black = "#000000",
	black2 = "#0d0a09",
	one_bg = "#15110e",
	one_bg2 = "#1d1712",
	one_bg3 = "#261e17",
	grey = "#685656",
	grey_fg = "#7a6a6a",
	grey_fg2 = "#8d7d7d",
	light_grey = "#a08f8f",
	red = "#d84a33",
	baby_pink = "#d76b42",
	pink = "#d76b42",
	line = "#241c16",
	green = "#5da602",
	vibrant_green = "#99b52c",
	nord_blue = "#417ab3",
	blue = "#417ab3",
	seablue = "#bdcfe5",
	yellow = "#eebb6e",
	sun = "#ffb670",
	purple = "#e5c499",
	dark_purple = "#aa7900",
	teal = "#bdcfe5",
	orange = "#d76b42",
	cyan = "#bdcfe5",
	statusline_bg = "#0d0a09",
	lightbg = "#15110e",
	pmenu_bg = "#0d0a09",
	folder_bg = "#417ab3",
}

M.base_16 = {
	base00 = "#040404",
	base01 = "#0d0a09",
	base02 = "#3a2a20",
	base03 = "#8d7d7d",
	base04 = "#a08f8f",
	base05 = "#feffff",
	base06 = "#ffffff",
	base07 = "#ffffff",
	base08 = "#d84a33",
	base09 = "#d76b42",
	base0A = "#eebb6e",
	base0B = "#5da602",
	base0C = "#bdcfe5",
	base0D = "#417ab3",
	base0E = "#e5c499",
	base0F = "#aa7900",
}

M.polish_hl = {
	defaults = {
		Comment = { italic = true },
	},
	treesitter = {
		["@comment"] = { italic = true },
	},
}

M.type = "dark"

return require("base46").override_theme(M, "adventure")
