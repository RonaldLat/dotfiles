return {
	"Saghen/blink.cmp",
	event = "InsertEnter",
	build = "cargo build --release",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets", -- Recommended for common snippets
		"moyiz/blink-emoji.nvim",
		"archie-judd/blink-cmp-words",
		{ "echasnovski/mini.icons", version = "*" },
	},
	config = function()
		require("blink.cmp").setup({
			-- Completion behavior
			completion = {
				-- accept = {
				-- 	-- Select with Enter key
				-- 	["<CR>"] = { "select_and_accept" },
				-- },
				-- menu = { border = "single" },
				-- { list = { selection = "manual" } },
				-- documentation = {
				-- 	auto_show = true,
				-- 	auto_show_delay_ms = 250,
				-- 	treesitter_highlight = true,
				-- 	window = { border = "rounded" },
				-- },
				menu = {
					border = "single",
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							kind = {
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
			},
			signature = { window = { border = "single" } },

			keymap = {
				-- preset = "enter",
				-- preset = "default",

				-- this ones also work fine
				-- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				-- ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = {
					function(cmp)
						return cmp.select_next()
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = {
					function(cmp)
						return cmp.select_prev()
					end,
					"snippet_backward",
					"fallback",
				},
				["<S-k>"] = { "scroll_documentation_up", "fallback" },
				["<Esc>"] = { "hide", "fallback" },
				["<S-j>"] = { "scroll_documentation_down", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			},

			sources = {
				-- Default sources for LSP, buffer, snippets, and path.
				-- blink.cmp often includes these by default, but
				-- explicitly listing them ensures they are active.
				default = {
					"lsp", -- Language Server Protocol completions
					"buffer", -- Words from current buffer
					"snippets", -- Snippets from LuaSnip/friendly-snippets
					"path", -- File system paths
					"emoji",
				},
				-- Providers can be further configured here if needed, e.g.,
				providers = {
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 93, -- the higher the number, the higher the priority
						min_keyword_length = 2,
						opts = { insert = true }, -- Insert emoji (default) or complete its name
					},
					lsp = {
						name = "lsp",
						enabled = true,
						module = "blink.cmp.sources.lsp",
						kind = "LSP",
						min_keyword_length = 2,

						-- When linking markdown notes, I would get snippets and text in the
						-- suggestions, I want those to show only if there are no LSP
						-- suggestions
						--
						-- Enabled fallbacks as this seems to be working now
						-- Disabling fallbacks as my snippets wouldn't show up when editing
						-- lua files
						-- fallbacks = { "snippets", "buffer" },
						score_offset = 90, -- the higher the number, the higher the priority
					},
					snippets = {
						name = "snippets",
						module = "blink.cmp.sources.snippets",
						max_items = 8,
					},
					thesaurus = {
						name = "blink-cmp-words",
						module = "blink-cmp-words.thesaurus",
						-- All available options
						opts = {
							-- A score offset applied to returned items.
							-- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
							score_offset = 0,

							-- Default pointers define the lexical relations listed under each definition,
							-- see Pointer Symbols below.
							-- Default is as below ("antonyms", "similar to" and "also see").
							pointer_symbols = { "!", "&", "^" },
						},
					},

					-- Use the dictionary source
					dictionary = {
						name = "blink-cmp-words",
						module = "blink-cmp-words.dictionary",
						-- All available options
						opts = {
							-- The number of characters required to trigger completion.
							-- Set this higher if completion is slow, 3 is default.
							dictionary_search_threshold = 3,

							-- See above
							score_offset = 0,

							-- See above
							pointer_symbols = { "!", "&", "^" },
						},
					},
				},
				per_filetype = {
					text = { "dictionary" },
					markdown = { "thesaurus" },
				},
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			snippets = {
				expand = function(snippet, _)
					require("luasnip").lsp_expand(snippet)
				end,
			},
		})
	end,
}
