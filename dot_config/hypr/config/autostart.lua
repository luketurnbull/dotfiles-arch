-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl enable --user app-com.mitchellh.ghostty.service")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("swaync")
	hl.exec_cmd("quickshell")
end)
