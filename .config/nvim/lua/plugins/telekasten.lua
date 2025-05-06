return {
	"renerocksai/telekasten.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("telekasten").setup({
			home = vim.fn.expand("~/zettelkasten"),
			dailies = vim.fn.expand("~/zettelkasten/dailies"),
			weeklies = vim.fn.expand("~/zettelkasten/weeklies"),
			templates = vim.fn.expand("~/zettelkasten/templates"),
			template_new_note = "~/zettelkasten/dailies/new.md", -- template for new notes
			template_new_daily = "~/zettelkasten/dailies/daily.md", -- template for new daily notes
			template_new_weekly = "~/zettelkasten/dailies/weekly.md", -- template for new weekly notes
			vaults = {
				personal = {
					-- configuration for personal vault. E.g.:
					home = vim.fn.expand("~/zettelkasten"),
				},
				work = {
					-- configuration for personal vault. E.g.:
					home = vim.fn.expand("~/zk/"),
				},
			},
		})

		-- Launch panel if nothing is typed after <leader>z
		vim.keymap.set("n", "<leader>zk", "<cmd>Telekasten panel<CR>")

		-- Most used functions
		vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
		vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
		vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
		vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
		vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
		vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
		vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
		vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")

		-- Call insert link automatically when we start typing a link
		vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")

		vim.api.nvim_set_hl(0, "tkHighlight", {
			bg = "yellow",
			fg = "darkred",
			bold = true,
		})
	end,
}
