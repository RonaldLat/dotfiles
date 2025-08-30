return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				svelte = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				toml = { "taplo", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				xml = { "xmlformatter", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },
				["_"] = { "trim_whitespace", "trim_newlines" },
				go = { "goimports" }, -- "gofumpt"
			},
			-- format_on_save = {
			-- 	-- These options will be passed to conform.format()
			-- 	timeout_ms = 2500,
			-- 	lsp_fallback = true,
			-- 	lsp_format = "fallback",
			-- },
		})

		-- Set up the keymap for manual formatting
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ lsp_fallback = true, async = false })
		end, { desc = "Format file" })
	end,
}
