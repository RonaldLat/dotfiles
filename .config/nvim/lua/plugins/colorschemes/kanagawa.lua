return {
	"rebelot/kanagawa.nvim",
	-- event = { "VeryLazy" },
	lazy = false,
	opts = {
		transparent = true,
	},
	config = function()
		require("kanagawa").setup({
			transparent = true,
		}) -- calling setup is optional
	end,
}
