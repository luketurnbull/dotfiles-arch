-- Look and feel
hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 2,

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
    active_opacity = 0.92,
    inactive_opacity = 0.80,

    shadow = {
      enabled = false,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },

    blur = {
      enabled = true,
      size = 9,
      passes = 4,
    },
  },
})

hl.curve("easy", { type = "spring", mass = 1, stiffness = 70, dampening = 15 })
hl.animation({ leaf = 'windows', enabled = true, speed = 1, spring = "easy" })

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
  scale     = 1.25,
})

-- Variables
local mainMod = "SUPER"
local terminal = "ghostty"
local browser = "zen-browser"

-- Autostart
hl.on("hyprland.start", function ()
  hl.exec_cmd("systemctl enable --user app-com.mitchellh.ghostty.service")
  hl.exec_cmd("clipse -listen")
end)

-- Keybinds
-- Open Windows
-- Terminal
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
-- class is coming through as "Bitwarden" not com.bitwarden when I type "hyprctl clients"
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("bitwarden-desktop --ozone-platform-hint=auto --class=com.bitwarden"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("ghostty --gtk-single-instance=false --class=com.clipse.clipboard -e clipse"))

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

hl.window_rule({
  name = "clipboard-window",
  match = { class = "^com\\.clipse\\.clipboard$" },
  center = true,
  float = true,
  size = "800 600",
})

hl.window_rule({
  name = "password-window",
  match = { class = "Bitwarden" },
  center = true,
  float = true,
  size = "800 800",
})
