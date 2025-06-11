return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim", "sharkdp/fd" },

	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local config = require("config.settings")
		local task_utils = require("utils.tasks")
		local OBSIDIAN_VAULT_PATH = vim.fn.expand("/home/ronald/Obsidian/lat96/")
		------------------------------------

		local function write_task_to_file(priority_tag_string, task_description, general_tags_string)
			local master_task_full_path = config.OBSIDIAN_VAULT_PATH .. "/" .. config.MASTER_TASK_FILENAME

			-- Format date and time as @YYYY-MM-DD HH:MM
			local timestamp = os.date(" @%Y-%m-%d %H:%M")

			-- Construct the task line with EXACT desired spacing and order
			local task_line = "- [ ]"
				.. priority_tag_string -- e.g., " #/priorityA"
				.. ": "
				.. task_description -- A colon and a space after priority tag
				.. general_tags_string -- e.g., " #inbox #home" (includes its own leading space if not empty)
				.. "  "
				.. timestamp -- Two spaces before timestamp
				.. "\n"

			local file = io.open(master_task_full_path, "a")
			if file then
				file:write(task_line)
				file:close()
				vim.notify("Task added to: " .. config.MASTER_TASK_FILENAME, vim.log.levels.INFO)
			else
				vim.notify("Error: Could not open " .. master_task_full_path .. " for writing.", vim.log.levels.ERROR)
			end
		end

		---
		--- Function to display task stats using vim.notify
		---
		local function display_task_stats()
			local stats_string = task_utils.get_task_stats_string()
			vim.notify(stats_string, vim.log.levels.INFO)
		end

		---
		--- Define keybindings (UPDATED <leader>tn SECTION)
		---
		vim.keymap.set("n", "<leader>tn", function()
			local priority_tag = ""
			local general_tags_list = {} -- List for general tags only

			-- 1. Get Task Description
			local task_description = vim.fn.input("New Task: ")
			if task_description == "" then
				print("Task creation cancelled.")
				return
			end

			-- 2. Get Priority Input and prepare priority tag
			local priority_input =
				vim.fn.input("Priority (e.g., A, B, C) [default: " .. config.DEFAULT_TASK_PRIORITY_VALUE .. "]: ")
			local effective_priority = config.DEFAULT_TASK_PRIORITY_VALUE

			if priority_input ~= "" then
				priority_input = priority_input:match("^%s*(.*%S?)%s*$")
				if priority_input:match("^%(%u%)$") then
					effective_priority = priority_input:sub(2, 2)
				elseif priority_input:match("^[A-Za-z]$") then
					effective_priority = string.upper(priority_input)
				else
					vim.notify(
						"Invalid priority format. Using default: " .. config.DEFAULT_TASK_PRIORITY_VALUE,
						vim.log.levels.WARN
					)
				end
			else
				vim.notify(
					"No priority provided. Using default: " .. config.DEFAULT_TASK_PRIORITY_VALUE,
					vim.log.levels.INFO
				)
			end
			-- Prepare priority tag string in the new format: " #/priorityA"
			priority_tag = " #/" .. effective_priority

			-- 3. Get General Tags Input and add to list
			local tags_input =
				vim.fn.input("General Tags (space separated, no #) [default: " .. config.DEFAULT_TASK_TAG .. "]: ")
			local has_user_provided_general_tags = false

			for tag_word in tags_input:gmatch("([^%s#]+)") do
				table.insert(general_tags_list, "#" .. tag_word)
				has_user_provided_general_tags = true
			end

			if not has_user_provided_general_tags and config.DEFAULT_TASK_TAG ~= "" then
				table.insert(general_tags_list, "#" .. config.DEFAULT_TASK_TAG)
				vim.notify(
					"No general tags provided. Using default general tag: #" .. config.DEFAULT_TASK_TAG,
					vim.log.levels.INFO
				)
			end

			-- Combine general tags into a single string, with a leading space if tags exist
			local general_tags_string_final = ""
			if #general_tags_list > 0 then
				general_tags_string_final = " " .. table.concat(general_tags_list, " ")
			end

			-- Pass the prepared strings to the write function
			write_task_to_file(priority_tag, task_description, general_tags_string_final)
		end, { desc = "[T]asks: [N]ew task with manual tags" })

		vim.keymap.set("n", "<leader>tc", display_task_stats, { desc = "[T]asks: [C]ount task stats" })

		vim.keymap.set("n", "<leader>tl", function()
			-- Store the current working directory before changing it
			local original_cwd = vim.fn.getcwd()

			-- Change to the Obsidian vault directory
			vim.cmd("cd " .. OBSIDIAN_VAULT_PATH)

			-- Run Telescope live_grep with the pre-filled query
			builtin.live_grep({
				default_text = "\\- \\[ \\]", -- Pre-fills the search input
				-- You can add other Telescope options specific to this picker here if needed
				-- e.g., a custom sorter, a different entry point, etc.
			})

			-- Change back to the original directory after Telescope closes
			-- This is crucial to avoid unintended side effects on other plugins
			-- or your general Neovim workflow.
			vim.cmd("cd " .. original_cwd)
		end, { desc = "[T]asks: Find [T]odo unchecked in vault" })

		-- Optional: A binding to find ALL tasks (checked and unchecked)
		vim.keymap.set("n", "<leader>tA", function()
			local original_cwd = vim.fn.getcwd()
			vim.cmd("cd " .. OBSIDIAN_VAULT_PATH)
			builtin.live_grep({
				default_text = "\\- \\[\\s*x*\\]", -- Pattern for "- [ ]" or "- [x]" (or even "- [ X]" if case-insensitive)
			})
			vim.cmd("cd " .. original_cwd)
		end, { desc = "[T]asks: Find [A]ll tasks in vault" })

		vim.keymap.set("n", "<leader>td", function()
			local original_cwd = vim.fn.getcwd()
			vim.cmd("cd " .. OBSIDIAN_VAULT_PATH)
			builtin.live_grep({
				default_text = "\\- \\[x\\]", -- Pattern for "- [x]"
			})
			vim.cmd("cd " .. original_cwd)
		end, { desc = "[T]asks: Find [D]one tasks in vault" })
	end,
}
