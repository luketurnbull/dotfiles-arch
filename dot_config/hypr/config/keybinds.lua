--------------------------------------------------------
-- Requires --------------------------------------------
--------------------------------------------------------
local variables = require("config.variables")
local appearance = require("config.appearance")
local mainMod = variables.mainMod

--------------------------------------------------------
-- Toggles -----------------------------------
--------------------------------------------------------
-- Toggle recording view
hl.bind("ALT + G", function()
	appearance.toggleGaps()
end)

--------------------------------------------------------
-- Open Applications -----------------------------------
--------------------------------------------------------
-- Terminal
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(variables.terminal))
-- Browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(variables.browser))
-- OBS Studio
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(variables.screenRecorder))
-- Obsidian
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(variables.noteEditor))
-- Blender
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(variables.blender))

--------------------------------------------------------
-- Audio keybinds --------------------------------------
--------------------------------------------------------
-- Volume up
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), {
	repeating = true,
})
-- Volume down
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), {
	repeating = true,
})
-- Mute
hl.bind(mainMod .. " + F10", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })

--------------------------------------------------------
-- Window Management -----------------------------------
--------------------------------------------------------
-- Close Active Window
hl.bind(mainMod .. " + W", hl.dsp.window.close())
-- Focus / move active window (hjkl + arrows)
local directions = {
	{ keys = { "h", "left" }, direction = "left" },
	{ keys = { "j", "down" }, direction = "down" },
	{ keys = { "k", "up" }, direction = "up" },
	{ keys = { "l", "right" }, direction = "right" },
}
for _, d in ipairs(directions) do
	for _, key in ipairs(d.keys) do
		hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = d.direction }))
		hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = d.direction }))
	end
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for _, i in ipairs(variables.workspaces) do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Quit Hyprland
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
