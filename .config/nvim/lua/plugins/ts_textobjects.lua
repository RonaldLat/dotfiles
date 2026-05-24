-- /home/ron/dotfiles/.config/nvim/lua/plugins/ts_textobjects.lua
return {
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.3", -- Keep this locked for Neovim 0.10
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "python", "javascript" },
				highlight = { enable = true },
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
						},
					},
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "master", -- 👈 Use the tracking branch so Lazy clones the history fully
		dependencies = { "nvim-treesitter" },
		lazy = false,
	},
}
