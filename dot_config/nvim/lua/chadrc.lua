-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

-- theme comes from the active theme dir (written by theme-set); fallback = static_noir
local theme = "static_noir"
local f = io.open(os.getenv("HOME") .. "/.config/themes/current/nvim", "r")
if f then
	theme = f:read("*l") or theme
	f:close()
end

M.base46 = {
	theme = theme,
	transparency = true,

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
	-- hide the top buffer tabline; nvchad's <leader>x close_buffer relies on
	-- tabufline's vim.t.bufs state, so mappings.lua provides its own remap
	tabufline = { enabled = false },
}

return M
