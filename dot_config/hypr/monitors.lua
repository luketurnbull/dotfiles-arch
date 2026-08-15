local laptopDisplayName = "eDP-1"
local hasLidDown = false
local externalMonitor = nil

local function setupMonitors()
	local laptopDisplay = {
		output = laptopDisplayName,
		disabled = hasLidDown,
		scale = 1.25,
	}

	if externalMonitor ~= nil then
		hl.monitor({
			output = externalMonitor,
			position = "0x0",
		})

		laptopDisplay.position = "auto-down"
	else
		laptopDisplay.position = "0x0"
	end

	hl.monitor(laptopDisplay)
end

local function checkExternalMonitors()
	externalMonitor = nil

	for _, monitor in ipairs(hl.get_monitors()) do
		if monitor.name ~= laptopDisplayName then
			externalMonitor = monitor.name
		end
	end
end

checkExternalMonitors()
setupMonitors()

hl.bind("switch:off:Lid Switch", function()
	hasLidDown = false
	setupMonitors()
end, { locked = true })

hl.bind("switch:on:Lid Switch", function()
	hasLidDown = true
	setupMonitors()
end, { locked = true })
