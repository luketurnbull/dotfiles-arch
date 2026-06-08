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
    active_opacity = 0.96,
    inactive_opacity = 0.90,

    shadow = {
      enabled = false,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },

    blur = {
      enabled = true,
      size = 1,
      passes = 1,
    },
  },
})

