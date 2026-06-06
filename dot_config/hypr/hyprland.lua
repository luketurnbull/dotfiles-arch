-- Variables
local mainMod = "SUPER"
local terminal = "ghostty"
local browser = "zen-browser"

-- Monitor: use 'hyprctl monitors` to get the real monitior details
hl.monitor({
  output    = "DP-2",
  mode      = "3440x1440@60",
  position  = "0x0",
  scale     = 1,
})

-- Keybinds
-- Open Windows
-- Terminal
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- Close Active Window
hl.bind(mainMod .. " + W", hl.dsp.window.close())

-- Quit Hyprland
hl.bind(mainMod .. " + M", hl.dsp.exit())



