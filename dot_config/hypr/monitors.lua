-- Monitor: use 'hyprctl monitors` to get the real monitior details
hl.monitor({
	output = "DP-2",
	mode = "3440x1440@60",
	position = "0x0",
	scale = 1.25,
})

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1.25,
})
