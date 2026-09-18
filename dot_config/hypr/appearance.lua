local horizontalGap = 362

local recordingGaps = {
	top = 5,
	bottom = 10,
	left = horizontalGap,
	right = horizontalGap,
}

local noneRecordingGap = {
	top = 0,
	bottom = 10,
	left = 10,
	right = 10,
}

-- Look and feel
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = recordingGaps,

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

local function toggleGaps()
	local gaps = hl.get_config("general.gaps_out")

	hl.notification.create({ text = gaps.left, timeout = 2000, icon = "ok" })

	if gaps.left == noneRecordingGap then
		hl.config({ general = { gaps_out = recordingGaps } })
		hl.notification.create({ text = "Gaps: 16/9 recording", timeout = 2000, icon = "ok" })
	else
		hl.config({ general = { gaps_out = noneRecordingGap } })
		hl.notification.create({ text = "Gaps: normal", timeout = 2000, icon = "ok" })
	end
end

return { toggleGaps = toggleGaps }
