-- ~/.config/nvim/lua/plugins/dadbod.lua (or similar)
return {
	{
		"tpope/vim-dadbod",
		-- Optional: If you want to configure specific adapters or behaviors
		-- config = function()
		--   vim.g.dadbod_default_driver = 'postgresql' -- Example default driver
		-- end,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		cmd = { "DBUI", "DBUIToggle" }, -- Define commands to load the plugin
		config = function()
			-- Optional: Customize Dadbod UI
			vim.g.db_ui_use_nerd_fonts = 1 -- If you have Nerd Fonts installed
			vim.g.db_ui_winwidth = 40 -- Set the width of the DBUI drawer
			-- You can also define global connections here or use environment variables
			-- vim.g.dbs = {
			--   dev = "postgresql://user:password@localhost:5432/my_dev_db",
			--   prod = "mysql://user:password@remote_host:3306/my_prod_db",
			-- }
		end,
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = { "tpope/vim-dadbod", "kristijanhusak/vim-dadbod-ui" },
		-- If you use nvim-cmp, you might need additional configuration
		-- For example, with nvim-cmp:
		-- event = "BufEnter *.sql", -- Load only when entering SQL files
		-- config = function()
		--   local cmp = require('cmp')
		--   cmp.setup.buffer {
		--     sources = {
		--       { name = 'vim-dadbod' },
		--       { name = 'buffer' },
		--     }
		--   }
		-- end,
	},
}
