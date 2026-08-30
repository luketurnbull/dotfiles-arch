--------------------------------------------------------
-- Audio keybinds --------------------------------------
--------------------------------------------------------
local variables = require("variables")
local mainMod = variables.mainMod

--------------------------------------------------------
-- Open Applications -----------------------------------
--------------------------------------------------------
-- Terminal
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(variables.terminal))
-- Browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(variables.browser))
-- OBS Studio
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(variables.screenRecorder))
-- Obsidian
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(variables.noteEditor))

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
