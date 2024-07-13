-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

---@class LocalBufferCommand
---@field mode string
---@field shortcut string
---@field cmd string
---@field opts vim.api.keyset.keymap?

---@param file_pattern string[]
---@param callback function()
local function register_callback_for_filetype(file_pattern, callback)
	for _, pattern in ipairs(file_pattern) do
		vim.api.nvim_create_autocmd("FileType", {
			pattern = pattern,
			callback = callback,
			group = vim.api.nvim_create_augroup(pattern .. "_autocommands_callback", { clear = true }),
		})
	end
end

wk.add({
	{ "<A-j>", ":m .+1<CR>", desc = "Move line up" },
	{ "<A-k>", ":m .-2<CR>", desc = "Move line down" },
})

wk.add({
	{ "<leader>uk", "<cmd>Screenkey<cr>", desc = "Toggle Screenkey" },
})

register_callback_for_filetype({ "cpp", "cmake" }, function()
	wk.add({
		{ "<leader>c", group = "CMake" },
		{ "<leader>cbb", "<cmd>CMakeBuild<CR>", desc = "Build" },
		{ "<leader>cbb", "<cmd>CMakeDebug<CR>", desc = "Debug" },
		{ "<leader>cbg", "<cmd>CMakeGenerate<CR>", desc = "Generate" },
		{ "<leader>cbs", "<cmd>CMakeSelectConfigurePreset<CR>", desc = "Select Configure Preset" },
		{ "<leader>cbc", "<cmd>CMakeClean<CR>", desc = "Clean" },
		{ "<leader>cbe", desc = "<cmd>CMakeOpenExecutor<CR>", "Show Output" },
		{ "<leader>cbE", "<cmd>CMakeCloseExecutor<CR>", desc = "Close Output" },
	})
end)

register_callback_for_filetype({ "go" }, function()
	wk.add({
		{ "<leader>c", group = "Go" },
		{ "<leader>cbb", ":GoBuild %:h<CR>", desc = "Build" },
		{ "<leader>cbc", ":GoCoverage -p<CR>", desc = "Coverage" },
		{ "<leader>cbi", desc = ":GoImports<CR>", "Imports" },
		{ "<leader>cbt", desc = ":GoTestPkg<CR>", "Test package" },
		{ "<leader>cbs", desc = ":lua require('go.alternate').switch(true, '')<CR>" },
		{
			"<leader>cbv",
			"Open test vertically.",
			desc = ":lua require('go.alternate').switch(true, 'vsplit')<CR>",
		},
		{
			"<leader>cbh",
			"Open test horizontally.",
			desc = ":lua require('go.alternate').switch(true, 'ssplit')<CR>",
		},
	})
end)

local oil = require("oil")
wk.add({
	{ "<leader>E", group = "[E]xplore folders" },
	{
		"<leader>Ep",
		function()
			require("oil").open(nil)
		end,
		desc = "Open [p]arent folder",
	},
	{
		"<leader>Ec",
		function()
			---@diagnostic disable-next-line: param-type-mismatch
			oil.open(vim.fn.stdpath("config"))
		end,
		desc = "Open [c]onfig folder",
	},
})
