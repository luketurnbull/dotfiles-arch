local themeBorders = require("lib.theme")

local horizontalGap = 362
local normalGap = 5

local recordingGaps = {
	top = 3,
	bottom = normalGap,
	left = horizontalGap,
	right = horizontalGap,
}

local noneRecordingGaps = {
	top = 3,
	bottom = normalGap,
	left = normalGap,
	right = normalGap,
}

-- Look and feel
hl.config({
	general = {
		gaps_in = 2,
		gaps_out = noneRecordingGaps,
		border_size = 1,

		col = {
			active_border = themeBorders.active,
			inactive_border = themeBorders.inactive,
		},

		layout = "dwindle",
	},

	decoration = {
		rounding = 8,
		rounding_power = 4,
		active_opacity = 0.85,
		inactive_opacity = 0.80,

		blur = {
			enabled = true,
			size = 2,
			passes = 6,
			brightness = 1,
			vibrancy = 1,
			vibrancy_darkness = 0,
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
