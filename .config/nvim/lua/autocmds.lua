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
	pattern = "*",
	callback = function()
		vim.defer_fn(autosave_markdown, autosave_interval)
	end,
})
