return {
	"tiagovla/tokyodark.nvim",
	event = { "VeryLazy" },
	opts = {
		-- custom options here
    transparency = true,
    transparent = true
	},
	config = function(_, opts)
		require("tokyodark").setup(opts) -- calling setup is optional
		-- vim.cmd [[colorscheme tokyodark]]
	end,
}
