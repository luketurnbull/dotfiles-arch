-- Look and feel
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 1,

		col = {
			active_border = { colors = { "rgb(3b4261)", "rgb(7aa2f7)" }, angle = 45 },
			inactive_border = "rgb(1a1b26)",
		},

		layout = "dwindle",
	},

	decoration = {
		rounding = 16,
		rounding_power = 4,
		active_opacity = 0.98,
		inactive_opacity = 0.94,

		blur = {
			enabled = true,
			size = 4,
			passes = 1,
			brightness = 1,
			vibrancy = 1,
			vibrancy_darkness = 0.2,
		},
	},

	misc = {
		force_default_wallpaper = true,
		disable_hyprland_logo = true,
		middle_click_paste = true,
		disable_splash_rendering = true,
		font_family = "Inter Regular",
	},
})
