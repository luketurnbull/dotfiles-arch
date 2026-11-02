local horizontalGap = 362

local recordingGaps = {
	top = 10,
	bottom = 10,
	left = horizontalGap,
	right = horizontalGap,
}

local noneRecordingGaps = {
	top = 10,
	bottom = 10,
	left = 10,
	right = 0,
}

-- Look and feel
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = recordingGaps,

		border_size = 1,

		col = {
			active_border = { colors = { "rgb(666666)", "rgb(ff3b30)" }, angle = 45 },
			inactive_border = "rgb(333333)",
		},

		layout = "dwindle",
	},

	decoration = {
		rounding = 16,
		rounding_power = 4,
		active_opacity = 0.96,
		inactive_opacity = 0.93,

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

local function toggleGaps()
	local gaps = hl.get_config("general.gaps_out")

	if gaps.left == horizontalGap then
		hl.config({ general = { gaps_out = noneRecordingGaps } })
	else
		hl.config({ general = { gaps_out = recordingGaps } })
	end
end

return { toggleGaps = toggleGaps }
