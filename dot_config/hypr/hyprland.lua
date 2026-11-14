require("config.appearance")
require("config.monitors")
require("config.animations")
require("config.keybinds")
require("config.devices")
require("config.autostart")

hl.window_rule({
	name = "supress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
