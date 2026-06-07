-- Look and feel
hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 3,

    border_size = 2,

    col = {
      active_border = { colors = {"rgba(33ccffee)"}, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },

    layout = "dwindle",
  },

  decoration = {
    -- rounding = 10,
    -- rounding_power = 2,
    active_opacity = 0.95,
    inactive_opacity = 0.85,

    shadow = {
      enabled = false,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },

    blur = {
      enabled = true,
      size = 9,
      passes = 3,
    },
  },
})
    
hl.config({
  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  },
})

-- Monitor: use 'hyprctl monitors` to get the real monitior details
hl.monitor({
  output    = "DP-2",
  mode      = "3440x1440@60",
  position  = "0x0",
  scale     = 1,
})

-- Variables
local mainMod = "SUPER"
local terminal = "ghostty"
local browser = "zen-browser"
-- Keybinds
-- Open Windows
-- Terminal
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

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

-- Quit Hyprland
hl.bind(mainMod .. " + M", hl.dsp.exit())


-- Float window
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))

-- Windows and Workspaces
hl.window_rule({
  name = "supress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

