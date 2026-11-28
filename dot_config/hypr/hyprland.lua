require("config.appearance")
require("config.monitors")
require("config.animations")
require("config.keybinds")
require("config.devices")
require("config.autostart")
local variables = require("config.variables")

hl.window_rule({
	name = "supress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

for _, workspace in ipairs(variables.workspaces) do
	hl.workspace_rule({
		workspace = workspace,
		persistent = true,
	})
end
