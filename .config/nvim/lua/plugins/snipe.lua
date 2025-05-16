return {
	"leath-dub/snipe.nvim",
	lazy = true,
	keys = {
		{
			-- "gb",
			",",
			function()
				require("snipe").open_buffer_menu()
			end,
			desc = "Open Snipe buffer menu",
		},
	},
	opts = {
		ui = {
			border = "rounded",
			---@type "topleft"|"bottomleft"|"topright"|"bottomright"|"center"|"cursor"

			position = "cursor",
			-- Provide custom buffer list format
			-- Available options:
			--  "filename" - basename of the buffer
			--  "directory" - buffer parent directory path
			--  "icon" - icon for buffer filetype from "mini.icons" or "nvim-web-devicons"
			--  string - any string, will be inserted as is
			-- fun(buffer_object): string,string - function that takes snipe.Buffer object as an argument
			--   and returns a string to be inserted and optional highlight group name
			buffer_format = {
				"->",
				"icon",
				"filename",
				-- "",
				-- "directory",
				function(buf)
					if vim.fn.isdirectory(vim.api.nvim_buf_get_name(buf.id)) == 1 then
						return "  ", " ", "SnipeText"
					end
				end,
			},
		},
		navigate = {
			cancel_snipe = "q",
			close_buffer = "x",
			close_buffer = "<Esc>",
		},
	},
}
