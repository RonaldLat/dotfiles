return {
	"nvim-treesitter/nvim-treesitter-context",
	-- event = { "BufReadPre", "BufNewFile" },
	event = { "BufReadPost" },
	{
		"windwp/nvim-ts-autotag",
		opts = {
			-- this shit is backwards lol
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- lazy = false,
		-- event = { "BufReadPre", "BufNewFile" },
		event = { "BufReadPost" },
		-- event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					-- 'diff',
					"go",
					-- 'gomod',
					"html",
					"java",
					"javascript",
					"jsdoc",
					"json",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"css",
					"svelte",
					-- 'query',
					-- 'rust',
					"tsx",
					"typescript",
					"python",
					"tsx",
					"toml",
					-- 'vim',
					-- 'vimdoc',
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				modules = {},
				sync_install = false,
				ignore_install = {},
			})
		end,
	},
}
