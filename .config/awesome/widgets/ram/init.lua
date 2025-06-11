-- In your rc.lua or a separate widget file

local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

-- Function to get available RAM
local function get_available_ram()
	awful.spawn.easy_async_count("bash -c \"free -m | grep Mem: | awk '{print $7}'\"", 1, function(stdout)
		local available_ram = tonumber(stdout)
		if available_ram then
			-- Update the widget text
			ram_widget.text = string.format("RAM: %d MB", available_ram)
		else
			ram_widget.text = "RAM: N/A"
			naughty.notify({
				preset = naughty.config.presets.critical,
				title = "RAM Widget Error",
				text = "Could not parse available RAM.",
			})
		end
	end)
end

-- Create the RAM widget
local ram_widget = wibox.widget({
	text = "RAM: Loading...",
	widget = wibox.widget.textbox,
	align = "right",
})

-- Update the widget initially
get_available_ram()

-- Set up a timer to update the widget every 5 seconds (adjust as needed)
awful.widget.watch(
	"bash -c \"free -m | grep Mem: | awk '{print $7}'\"",
	5, -- Update every 5 seconds
	function(setter, stdout)
		local available_ram = tonumber(stdout)
		if available_ram then
			setter(string.format("RAM: %d MB", available_ram))
		else
			setter("RAM: N/A")
			naughty.notify({
				preset = naughty.config.presets.critical,
				title = "RAM Widget Error",
				text = "Could not parse available RAM (timer update).",
			})
		end
	end,
	ram_widget -- Pass the widget to be updated
)

-- Return the widget so it can be added to the wibox
return ram_widget
