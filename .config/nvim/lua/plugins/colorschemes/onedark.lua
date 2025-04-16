return {
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "deep", -- Already present
				-- style = "cool", -- Already present
				-- style = "dark", -- Already present
				-- style = "warm", -- Already present
				-- Add your new settings here as key-value pairs
				-- For example:
				transparent = true,
				term_colors = true,
				-- ... other settings ...
			})
			require("onedark").load()
		end,
	},
}
