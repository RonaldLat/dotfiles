-- ~/.config/nvim/lua/config/settings.lua

local M = {}

-- --- Obsidian Vault Settings ---
M.OBSIDIAN_VAULT_PATH = vim.fn.expand("~/Obsidian/lat96") -- <-- SET YOUR ACTUAL VAULT PATH!
M.MASTER_TASK_FILENAME = "Tasks.md" -- <-- SET YOUR MASTER TASK FILE NAME!

-- --- Default Task Settings ---
M.DEFAULT_TASK_TAG = "inbox"
M.DEFAULT_TASK_PRIORITY_VALUE = "C"

return M
