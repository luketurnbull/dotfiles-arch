local horizontalGap = 362
local normalGap = 5

local recordingGaps = {
	top = normalGap,
	bottom = normalGap,
	left = horizontalGap,
	right = horizontalGap,
}

local noneRecordingGaps = {
	top = normalGap,
	bottom = normalGap,
	left = normalGap,
	right = 0,
}

-- Look and feel
hl.config({
	general = {
		gaps_in = 2,
		gaps_out = recordingGaps,
		border_size = 1,

		col = {
			active_border = "rgb(ff3b30)",
			inactive_border = "rgb(000000)",
		},

		layout = "dwindle",
	},

	decoration = {
		rounding = 16,
		rounding_power = 4,
		active_opacity = 0.94,
		inactive_opacity = 0.92,

		blur = {
			enabled = true,
			size = 4,
			passes = 3,
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
