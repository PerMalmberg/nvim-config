-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.spell = true
opt.spelllang = "en_us"
opt.vb = true
opt.fileencoding = "utf-8"
opt.encoding = "utf-8"

-- 	https://github.com/CopilotC-Nvim/CopilotChat.nvim
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
