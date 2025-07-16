-- ~/.config/awesome/modules/xrandr_manager.lua
-- Separating Multiple Monitor functions as a separeted module
-- slightly modified version of https://awesomewm.org/recipes/xrandr.lua

local gtable = require("gears.table")
local spawn = require("awful.spawn")
local naughty = require("naughty")
local beautiful = require("beautiful")
local mouse = mouse -- AwesomeWM global for mouse position

local xrandr = {
	state = { cid = nil },
	position = "right-of", -- Changed default to "right-of" for common side-by-side setup
}

-- Get active outputs
local function outputs()
	local _outputs = {}
	local handle = io.popen("xrandr -q --current")
	if handle then
		for line in handle:lines() do
			-- This regex will capture output names like eDP-1, HDMI-2, DP-1, etc.
			local output = line:match("^([%w-]+) connected ")
			if output then
				_outputs[#_outputs + 1] = output
			end
		end
		handle:close()
	end

	return _outputs
end

-- We need to enumerate all permutations of horizontal outputs.
local function arrange(out)
	local choices = {}
	local previous = { {} }
	for _ = 1, #out do
		local new = {}
		for _, p in pairs(previous) do
			for _, o in pairs(out) do
				if not gtable.hasitem(p, o) then
					new[#new + 1] = gtable.join(p, { o })
				end
			end
		end
		choices = gtable.join(choices, new)
		previous = new
	end
	return choices
end

-- Build available choices
local function menu()
	local _menu = {}
	local out = outputs()
	local choices = arrange(out)

	-- Add option to disable all external monitors and use only primary (eDP-1)
	-- This ensures a "laptop only" option if the laptop screen is eDP-1
	local laptop_only_cmd = "xrandr"
	local primary_output_found = false
	for _, o in pairs(out) do
		if o == "eDP-1" then -- Assuming eDP-1 is your primary laptop screen
			laptop_only_cmd = laptop_only_cmd .. " --output " .. o .. " --auto --primary"
			primary_output_found = true
		else
			laptop_only_cmd = laptop_only_cmd .. " --output " .. o .. " --off"
		end
	end
	if primary_output_found then
		_menu[#_menu + 1] = { 'Only <span weight="bold">eDP-1</span> (Laptop)', laptop_only_cmd }
	end

	for _, choice in pairs(choices) do
		local cmd = "xrandr"
		-- Enabled outputs
		for i, o in pairs(choice) do
			cmd = cmd .. " --output " .. o .. " --auto"
			if i > 1 then
				-- Position relative to the *previous* monitor in the permutation
				cmd = cmd .. string.format(" --%s ", xrandr.position) .. choice[i - 1]
			else
				-- The first monitor in the permutation is primary
				cmd = cmd .. " --primary"
			end
		end
		-- Disabled outputs
		for _, o in pairs(out) do
			if not gtable.hasitem(choice, o) then
				cmd = cmd .. " --output " .. o .. " --off"
			end
			-- If you also want to specifically set the main laptop screen to primary if it's part of the arrangement
			-- Example: ensure eDP-1 is always primary if it's connected
			-- if gtable.hasitem(choice, "eDP-1") then
			--    cmd = cmd .. " --output eDP-1 --primary"
			-- end
		end

		local label = ""
		if #choice == 1 then
			label = 'Only <span weight="bold">' .. choice[1] .. "</span>"
		else
			for i, o in pairs(choice) do
				if i > 1 then
					label = label .. " + "
				end
				label = label .. '<span weight="bold">' .. o .. "</span>"
			end
		end

		_menu[#_menu + 1] = { label, cmd }
	end

	return _menu
end

local function naughty_destroy_callback(reason)
	if
		reason == naughty.notificationClosedReason.expired
		or reason == naughty.notificationClosedReason.dismissedByUser
	then
		-- Retrieve the command that was associated with the dismissed notification
		local action = xrandr.state.index and xrandr.state.menu[xrandr.state.index - 1]
		if action then
			print("Executing xrandr command: " .. action[2]) -- Debug print to ~/.xsession-errors
			awful.spawn.easy_async(action[2], function(stdout, stderr, exitreason, exitcode)
				if exitcode ~= 0 then
					naughty.notify({
						text = "xrandr command failed:\n" .. stderr,
						preset = naughty.config.presets.critical,
						timeout = 5,
						screen = mouse.screen,
					})
					print("xrandr error: " .. stderr) -- Debug print for errors
				else
					-- Optional: Show success notification
					-- naughty.notify({
					--     text = "Monitor configuration applied: " .. action[1],
					--     timeout = 2,
					--     screen = mouse.screen,
					-- })
					print("xrandr command successful.")
				end
			end)
			xrandr.state.index = nil -- Reset index after executing command
		end
	end
end

function xrandr.show()
	-- Build the list of choices if not already built
	if not xrandr.state.index then
		xrandr.state.menu = menu()
		-- Sort menu items for consistent ordering (optional, but helpful)
		table.sort(xrandr.state.menu, function(a, b)
			return a[1] < b[1]
		end)
		xrandr.state.index = 1
	end

	-- Select one and display the appropriate notification
	local label
	local next_option = xrandr.state.menu[xrandr.state.index]
	xrandr.state.index = xrandr.state.index + 1

	if not next_option then
		-- If we've cycled through all options, display "Keep current" and reset for next cycle
		label = "Keep the current configuration"
		xrandr.state.index = nil -- Reset index for the next full cycle
		-- No command to execute if "Keep current" is selected
		xrandr.state.cid = naughty.notify({
			text = label,
			icon = "/usr/share/icons/" .. beautiful.icon_theme .. "/32x32/devices/display.svg",
			timeout = 4,
			screen = mouse.screen,
			replaces_id = xrandr.state.cid,
			destroy = naughty_destroy_callback, -- This will still be called, but action will be nil
		}).id
	else
		label = next_option[1]
		xrandr.state.cid = naughty.notify({
			text = label,
			icon = "/usr/share/icons/" .. beautiful.icon_theme .. "/32x32/devices/display.svg",
			timeout = 4,
			screen = mouse.screen,
			replaces_id = xrandr.state.cid,
			destroy = naughty_destroy_callback,
		}).id
	end
end

return xrandr
