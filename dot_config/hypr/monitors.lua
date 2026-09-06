local laptopDisplayName = "eDP-1"
local hasLidDown = true
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
			scale = 1.25,
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

local function configureAll()
	checkExternalMonitors()
	setupMonitors()
end

configureAll()

hl.bind("switch:off:Lid Switch", function()
	hasLidDown = false
	configureAll()
end, { locked = true })

hl.bind("switch:on:Lid Switch", function()
	hasLidDown = true
	configureAll()
end, { locked = true })

return {
	configureAll = configureAll,
}
