---@type Base46Table
local M = {}

M.base_30 = {
	white = "#e6e1d9",
	black = "#0f0b0a",
	darker_black = "#0a0807",
	black2 = "#171210",
	one_bg = "#1f1815",
	one_bg2 = "#281e1a",
	one_bg3 = "#31241f",
	grey = "#6b5b4f",
	grey_fg = "#7d6c60",
	grey_fg2 = "#8f7d6f",
	light_grey = "#cbb89f",
	red = "#ff6b6b",
	baby_pink = "#ff8b8b",
	pink = "#ff8b8b",
	line = "#2c211b",
	green = "#4ade80",
	vibrant_green = "#86efac",
	nord_blue = "#60a5fa",
	blue = "#60a5fa",
	seablue = "#2dd4bf",
	yellow = "#f59e0b",
	sun = "#fbbf24",
	purple = "#c084fc",
	dark_purple = "#9d6ce0",
	teal = "#2dd4bf",
	orange = "#f59e0b",
	cyan = "#2dd4bf",
	statusline_bg = "#171210",
	lightbg = "#1f1815",
	pmenu_bg = "#171210",
	folder_bg = "#60a5fa",
}

M.base_16 = {
	base00 = "#0f0b0a",
	base01 = "#171210",
	base02 = "#3d2f27",
	base03 = "#8f7d6f",
	base04 = "#cbb89f",
	base05 = "#e6e1d9",
	base06 = "#f2ede9",
	base07 = "#fdfaf6",
	base08 = "#ff6b6b",
	base09 = "#f59e0b",
	base0A = "#fbbf24",
	base0B = "#4ade80",
	base0C = "#2dd4bf",
	base0D = "#60a5fa",
	base0E = "#c084fc",
	base0F = "#d4af37",
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

return require("base46").override_theme(M, "after_hours")
