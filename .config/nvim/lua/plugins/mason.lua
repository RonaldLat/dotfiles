-- plugins/mason.lua (or wherever you configure Mason)
return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", -- Lua language server
				"pyright", -- Python language server
				"taplo", -- toml formatter
				"yamlfmt",
				"yamllint",
				"write-good",
				"vale",
				-- "tsserver",       -- TypeScript language server
				-- "rust_analyzer",  -- Rust language server
				"gopls", -- Go language server
				-- "stylua",          -- Go language server
				-- TODO: ensure install stylua
				"marksman", -- Go language server
				-- Add any other LSP servers you want to auto-install here
			},
		})
	end,
}

-- {
--   'williamboman/mason-lspconfig.nvim',
--   event = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     'williamboman/mason.nvim'
--   }
