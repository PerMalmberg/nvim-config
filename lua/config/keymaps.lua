-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map_global = vim.keymap.set
local wk = require("which-key")

---@class LocalBufferCommand
---@field mode string
---@field shortcut string
---@field cmd string
---@field opts vim.api.keyset.keymap?

---@param file_pattern string
---@param commands LocalBufferCommand[]
local function register_command_for_filetype(file_pattern, commands)
	local callback = function()
		for _, cmd in ipairs(commands) do
			vim.api.nvim_buf_set_keymap(0, cmd.mode, cmd.shortcut, cmd.cmd, cmd.opts or {})
		end
	end

	vim.api.nvim_create_autocmd("FileType", {
		pattern = file_pattern,
		callback = callback,
		group = vim.api.nvim_create_augroup(file_pattern .. "_autocommands", { clear = true }),
	})
end

map_global("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
map_global("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
map_global("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
map_global("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- Go keymaps for go.nvim
register_command_for_filetype("go", {
	{
		mode = "n",
		shortcut = "<leader>ci",
		cmd = ":GoImports<CR>",
		opts = { silent = true, desc = "Go Imports" },
	},
	{
		mode = "n",
		shortcut = "<leader>cb",
		cmd = ":GoBuild %:h<CR>",
		opts = { silent = true, desc = "Go Build" },
	},
	{
		mode = "n",
		shortcut = "<leader>ct",
		cmd = ":GoTestPkg<CR>",
		opts = { silent = true, desc = "Go Test Package" },
	},
	{
		mode = "n",
		shortcut = "<leader>cc",
		cmd = ":GoCoverage -p<CR>",
		opts = { silent = true, desc = "Go Coverage" },
	},
	{
		mode = "n",
		shortcut = "<leader>cT",
		cmd = ":lua require('go.alternate').switch(true, '')<CR>",
		opts = { silent = true, desc = "Switch to Test file" },
	},
	{
		mode = "n",
		shortcut = "<leader>cV",
		cmd = ":lua require('go.alternate').switch(true, 'vsplit')<CR>",
		opts = { silent = true, desc = "Switch to test file, V-split" },
	},
	{
		mode = "n",
		shortcut = "<leader>cH",
		cmd = ":lua require('go.alternate').switch(true, 'split')<CR>",
		opts = { silent = true, desc = "Switch to test file, H-split" },
	},
})

register_command_for_filetype("cpp", {})

wk.register({
	["<leader>cb"] = {
		name = "+cmake",
		b = { "<cmd>CMakeBuild<CR>", "Build" },
		d = { "<cmd>CMakeDebug<CR>", "Debug" },
		g = { "<cmd>CMakeGenerate<CR>", "Generate" },
		s = { "<cmd>CMakeSelectConfigurePreset<CR>", "Select Configure Preset" },
		c = { "<cmd>CMakeClean<CR>", "Clean" },
		e = { "<cmd>CMakeOpenExecutor<CR>", "Show Output" },
		E = { "<cmd>CMakeCloseExecutor<CR>", "Close Output" },
	},
})
