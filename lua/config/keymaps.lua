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

wk.register({
	["<A-j>"] = { ":m .+1<CR>==", "Move line up" },
	["<A-k>"] = { ":m .-2<CR>==", "Move line down" },
}, { silent = true })

wk.register({
	["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move line up" },
	["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move line down" },
}, { silent = true, mode = "v" })

wk.register({
	["<leader>u"] = {
		k = { "<cmd>Screenkey<cr>", "Toggle Screenkey" },
	},
})

register_callback_for_filetype({ "cpp", "cmake" }, function()
	wk.register({
		["<leader>cb"] = {
			name = "+CMake",
			b = { "<cmd>CMakeBuild<CR>", "Build" },
			d = { "<cmd>CMakeDebug<CR>", "Debug" },
			g = { "<cmd>CMakeGenerate<CR>", "Generate" },
			s = { "<cmd>CMakeSelectConfigurePreset<CR>", "Select Configure Preset" },
			c = { "<cmd>CMakeClean<CR>", "Clean" },
			e = { "<cmd>CMakeOpenExecutor<CR>", "Show Output" },
			E = { "<cmd>CMakeCloseExecutor<CR>", "Close Output" },
		},
		{
			buffer = 0,
			silent = true,
		},
	})
end)

register_callback_for_filetype({ "go" }, function()
	wk.register({
		["<leader>cb"] = {
			name = "+Go",
			b = { ":GoBuild %:h<CR>", "Build" },
			c = { ":GoCoverage -p<CR>", "Coverage" },
			i = { ":GoImports<CR>", "Imports" },
			t = { ":GoTestPkg<CR>", "Test package" },
			s = { ":lua require('go.alternate').switch(true, '')<CR>" },
			v = { ":lua require('go.alternate').switch(true, 'vsplit')<CR>", "Open test vertically." },
			h = { ":lua require('go.alternate').switch(true, 'ssplit')<CR>", "Open test horizontally." },
		},
		{
			buffer = 0,
			silent = true,
		},
	})
end)

local oil = require("oil")
wk.register({
	["<leader>E"] = {
		name = "[e]xplore folders",
		p = {
			function()
				require("oil").open(nil)
			end,
			"Open [p]arent folder",
		},
		c = {
			function()
				---@diagnostic disable-next-line: param-type-mismatch
				oil.open(vim.fn.stdpath("config"))
			end,
			"Open [c]onfig folder",
		},
	},
}, { silent = true })

-- Keymaps for navigator.
wk.register({}, {
	silent = true,
})
