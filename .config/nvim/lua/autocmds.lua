local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local smailiGroup = augroup("smaili", { clear = true })

-- Go to the last cursor position when reopening buffer
-- autocmd("BufReadPost", {
-- 	group = smailiGroup,
-- 	desc = "Restore last cursor position",
-- 	callback = function()
-- 		vim.defer_fn(function()
-- 			if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
-- 				vim.cmd('normal! g`"')
-- 			end
-- 		end, 0)
-- 	end,
-- })

autocmd("BufReadPost", {
	group = smailiGroup,
	desc = "Restore last cursor position",
	callback = function()
		-- Check if the buffer was opened as part of a command like Telescope's jump
		-- If vim.v.swapcommand is not empty, it implies a command initiated the buffer read.
		if vim.v.swapcommand ~= "" then
			return -- Skip restoring cursor for programmatic jumps
		end

		vim.defer_fn(function()
			if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
				vim.cmd('normal! g`"')
			end
		end, 0)
	end,
})

--- Disable auto-commenting on newline
autocmd("FileType", {
	pattern = "*",
	group = smailiGroup,
	desc = "Disable auto comment on new lines",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Function to save the current buffer

local function autosave_markdown()
	if vim.bo.filetype == "markdown" then
		vim.cmd("silent w") -- 'silent' prevents the "written" message
	end
end

-- Set the autosave interval (in milliseconds)
local autosave_interval = 10000 -- Save every 5 seconds

-- Create an autocmd that triggers the autosave function periodically
vim.api.nvim_create_autocmd("CursorHold", {
	-- * /this autocmd applies to all buffers
	pattern = "*.md",
	callback = function()
		vim.defer_fn(autosave_markdown, autosave_interval)
	end,
})

-- Define an autocommand group to manage your autocmds.
-- This is good practice to prevent autocmds from being duplicated
-- if you source your config multiple times.
local lat96_markdown_augroup = vim.api.nvim_create_augroup("Lat96Markdown", { clear = true })

-- Create the autocommand
vim.api.nvim_create_autocmd("BufReadPost", {
	group = lat96_markdown_augroup,
	pattern = "lat96/*.md",
	callback = function()
		-- !!! IMPORTANT: Replace 'YourMarkdownPreviewCommand' or 'YourMarkdownPreviewFunction()'
		-- with the actual command or function provided by your markdown preview plugin.

		-- Option 1: If your plugin provides a direct Vim command (e.g., :MarkdownPreview)
		vim.cmd("silent! YourMarkdownPreviewCommand")

		-- Option 2: If your plugin provides a Lua function to call (less common for direct preview commands)
		-- If your plugin exposes a Lua function like `require('your_plugin').preview()`, you'd use:
		-- pcall(require('your_plugin').preview)

		-- Option 3: If your plugin provides a Vimscript function to call (e.g., :call MyPlugin#Preview())
		-- vim.cmd("silent! call YourMarkdownPreviewFunction()")
	end,
	desc = "Automatically render markdown files in lat96 directory",
})
