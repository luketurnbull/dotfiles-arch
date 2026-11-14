local laptopDisplayName = "eDP-1"
local hasLidDown = false
local externalMonitor = nil

local function setupMonitors()
	local laptopDisplay = {
		output = laptopDisplayName,
		-- never disable the only remaining display (lid closed, nothing plugged in)
		disabled = hasLidDown and externalMonitor ~= nil,
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

-- Hotplug: deferred so monitor reconfig never runs synchronously inside the
-- event-handler call stack
local function scheduleConfigure()
	hl.timer(configureAll, { type = "oneshot", timeout = 1 })
end

hl.on("monitor.added", scheduleConfigure)
hl.on("monitor.removed", scheduleConfigure)

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
