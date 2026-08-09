require("appearance")
require("monitors")

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
-- hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
-- hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
-- hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
-- hl.curve("easy", { type = "spring", mass = 1, stiffness = 70, dampening = 15 })
--
-- hl.animation({ leaf = 'windows', enabled = true, speed = 1, spring = "easy" })
-- -- hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "easeInOutCubic" })
-- hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
--
-- Variables
local mainMod = "ALT"
local terminal = "ghostty"
local browser = "qutebrowser"

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl enable --user app-com.mitchellh.ghostty.service")
	hl.exec_cmd("clipse -listen")
	hl.exec_cmd("bitwarden-desktop --ozone-platform-hint=auto")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("swaync")
end)

-- Keybinds
-- Open Windows
-- Terminal
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))

-- Browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- Obsidian
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))

-- Blender
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("blender"))

-- Clipboard
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd("ghostty --gtk-single-instance=false --class=com.clipse.clipboard -e clipse")
)
-- Password Manager
hl.bind(mainMod .. " + A", hl.dsp.workspace.toggle_special("password-window"))
-- Audio controls
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("pwvucontrol"))

-- Audio keybinds
-- Turn up
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), {
	repeating = true,
})
-- Turn down
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), {
	repeating = true,
})
-- Mute
hl.bind(mainMod .. " + F10", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })

-- Close Active Window
hl.bind(mainMod .. " + W", hl.dsp.window.close())

-- Change active window focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

-- Move active window
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Quit Hyprland
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())

-- Windows and Workspaces
hl.window_rule({
	name = "supress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "clipboard-window",
	match = { class = "^com\\.clipse\\.clipboard$" },
	center = true,
	float = true,
	size = { 800, 600 },
	dim_around = true,
	rounding = 20,
	xray = true,
})

hl.window_rule({
	name = "password-window",
	match = { class = "Bitwarden" },
	workspace = "special:password-window silent",
	center = true,
	float = true,
	size = { 1000, 800 },
	animation = "fade",
	dim_around = true,
	rounding = 20,
	xray = true,
})

hl.window_rule({
	name = "audio-mixer",
	match = { class = "com.saivert.pwvucontrol" },
	center = true,
	float = true,
	size = { 800, 500 },
	dim_around = true,
	rounding = 20,
	xray = true,
})
