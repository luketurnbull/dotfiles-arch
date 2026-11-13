---@type Base46Table
local M = {}

M.base_30 = {
	white = "#e6f1ff",
	black = "#050814",
	darker_black = "#03060f",
	black2 = "#0a0f1f",
	one_bg = "#10182e",
	one_bg2 = "#16203a",
	one_bg3 = "#1c2545",
	grey = "#263449",
	grey_fg = "#45536b",
	grey_fg2 = "#5a6a85",
	light_grey = "#aab7c8",
	red = "#ff6b6b",
	baby_pink = "#ff8b8b",
	pink = "#ff8b8b",
	line = "#1a2743",
	green = "#5fd9ad",
	vibrant_green = "#80e5bd",
	nord_blue = "#6ea8ff",
	blue = "#6ea8ff",
	seablue = "#54ddeb",
	yellow = "#ffd166",
	sun = "#ffe28a",
	purple = "#c58cff",
	dark_purple = "#a875e0",
	teal = "#54ddeb",
	orange = "#ffb670",
	cyan = "#54ddeb",
	statusline_bg = "#0a0f1f",
	lightbg = "#10182e",
	pmenu_bg = "#00e5ff",
	folder_bg = "#6ea8ff",
}

M.base_16 = {
	base00 = "#050814",
	base01 = "#0a0f1f",
	base02 = "#263449",
	base03 = "#5a6a85",
	base04 = "#aab7c8",
	base05 = "#e6f1ff",
	base06 = "#f0f6ff",
	base07 = "#ffffff",
	base08 = "#ff6b6b",
	base09 = "#ffb670",
	base0A = "#ffd166",
	base0B = "#5fd9ad",
	base0C = "#54ddeb",
	base0D = "#6ea8ff",
	base0E = "#c58cff",
	base0F = "#00e5ff",
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

return require("base46").override_theme(M, "aurora_drift")
