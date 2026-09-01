-- Look and feel
hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,

		border_size = 1,

		col = {
			active_border = { colors = { "rgba(7aa2f7ee)" }, angle = 45 },
			inactive_border = "rgba(414868aa)",
		},

		layout = "dwindle",
	},

	decoration = {
		-- rounding = 10,
		-- rounding_power = 2,
		active_opacity = 0.99,
		inactive_opacity = 0.97,

		blur = {
			enabled = true,
			size = 1,
			passes = 2,
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
