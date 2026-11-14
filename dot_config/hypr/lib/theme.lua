-- Border colours from the active theme (written by theme-set); fallback = noir
local borders = { active = "rgb(444444)", inactive = "rgb(000000)" }
local ok, theme = pcall(dofile, os.getenv("HOME") .. "/.config/themes/current/hyprland.lua")
if ok and type(theme) == "table" then
	borders = theme
end
return borders
