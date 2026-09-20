require("appearance")
require("monitors")
require("animations")
require("keybinds")
require("devices")

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl enable --user app-com.mitchellh.ghostty.service")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("swaync")
	hl.exec_cmd("quickshell")
end)

hl.window_rule({
	name = "supress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
