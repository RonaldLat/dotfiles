return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	lazy = true,
	event = { "BufReadPost", "BufNewFile", "VeryLazy" },
	config = function()
		local task_utils = require("utils.tasks")

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "ayu", -- Or your preferred theme, e.g., 'tokyonight', 'dracula'
				component_separators = { "", "" }, -- Powerline-style separators (keep for a clean look)
				section_separators = { "", "" }, -- Powerline-style separators
				disabled_filetypes = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000, -- Refresh statusline every 1 second (adjust as needed)
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "branch" }, -- Git branch on the far left
				lualine_b = {}, -- Empty this section
				-- lualine_c = { task_stats_utils.get_task_stats_string }, -- Task stats in the center/main area
				lualine_x = {}, -- Empty this section
				lualine_y = {}, -- Empty this section
				lualine_z = { task_utils.get_task_stats_string }, -- Empty this section
			},
			inactive_sections = { -- What to show when the window is not active
				lualine_a = {}, -- Git branch usually not needed in inactive windows
				lualine_b = {},
				lualine_c = { task_utils.get_task_stats_string }, -- Optionally show task stats in inactive windows too
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			extensions = {},
		})
	end,
}
