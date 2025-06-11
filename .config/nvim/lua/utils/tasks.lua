-- ~/.config/nvim/lua/utils/tasks.lua

local M = {}

-- Require centralized settings
local config = require("config.settings")

-- Helper function for normalizing globpath output
local function normalize_globpath_output(raw_output)
	if type(raw_output) == "string" then
		if raw_output == "" then
			return {}
		else
			return { raw_output }
		end
	elseif type(raw_output) == "table" then
		return raw_output
	end
	return {}
end

--- Function to get task stats as a formatted string for the statusline.
function M.get_task_stats_string()
	local vault_path = config.OBSIDIAN_VAULT_PATH

	local markdown_files_raw = vim.fn.globpath(vault_path .. "/**", "*.md", 0, 1)
	local markdown_files = normalize_globpath_output(markdown_files_raw)

	if #markdown_files == 0 then
		return "Tasks: N/A"
	end

	local total_pending_count = 0
	local total_completed_count = 0
	local processed_files_count = 0

	for _, filepath in ipairs(markdown_files) do
		local file = io.open(filepath, "r")
		if file then
			processed_files_count = processed_files_count + 1
			for line in file:lines() do
				if line:match("^- %[ %] ") then -- Matches pending tasks: - [ ]
					total_pending_count = total_pending_count + 1
				elseif line:match("^- %[x%] ") or line:match("^- %[X%] ") then -- Matches completed tasks: - [x] or - [X]
					total_completed_count = total_completed_count + 1
				end
			end
			file:close()
		end
	end

	if processed_files_count == 0 then
		return "Tasks: N/A"
	else
		local total_tasks = total_pending_count + total_completed_count
		local completed_percentage = 0
		if total_tasks > 0 then
			completed_percentage = math.floor((total_completed_count / total_tasks) * 100 + 0.5)
		end

		-- Robust format for statusline
		return string.format(
			"Tasks: %d/%d [C:%d; %d%%%%]",
			total_pending_count,
			total_tasks,
			total_completed_count,
			completed_percentage
		)
	end
end

--- NEW FUNCTION: Get all task lines formatted as Telescope entries.
-- Each entry includes the task string, its file path, and line number.
function M.get_all_task_lines_for_telescope()
	local vault_path = config.OBSIDIAN_VAULT_PATH
	local markdown_files_raw = vim.fn.globpath(vault_path .. "/**", "*.md", 0, 1)
	local markdown_files = normalize_globpath_output(markdown_files_raw)

	local all_task_entries = {}

	for _, filepath in ipairs(markdown_files) do
		local file = io.open(filepath, "r")
		if file then
			local current_line_num = 0
			for line_content in file:lines() do
				current_line_num = current_line_num + 1
				-- Check for both pending and completed tasks
				if
					line_content:match("^- %[ %] ")
					or line_content:match("^- %[x%] ")
					or line_content:match("^- %[X%] ")
				then
					table.insert(all_task_entries, {
						value = line_content, -- The full task line string (used for fuzzy matching/sorter)
						display = line_content, -- How it's displayed by default (can be overridden by entry_display.create)
						filepath = filepath, -- Full path to the file where the task is located
						lnum = current_line_num, -- Line number of the task within that file
					})
				end
			end
			file:close()
		end
	end
	return all_task_entries
end

return M
