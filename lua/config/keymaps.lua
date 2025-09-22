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

register_callback_for_filetype({ "cpp", "cmake" }, function()
  wk.add({
    { "<leader>C", group = "CMake" },
    { "<leader>Cb", "<cmd>CMakeBuild<CR>", desc = "Build" },
    { "<leader>Cd", "<cmd>CMakeDebug<CR>", desc = "Debug" },
    { "<leader>Cg", "<cmd>CMakeGenerate<CR>", desc = "Generate" },
    { "<leader>Cs", "<cmd>CMakeSelectConfigurePreset<CR>", desc = "Select Configure Preset" },
    { "<leader>Cc", "<cmd>CMakeClean<CR>", desc = "Clean" },
    { "<leader>Ce", "<cmd>CMakeOpenExecutor<CR>", desc = "Show Output" },
    { "<leader>CE", "<cmd>CMakeCloseExecutor<CR>", desc = "Close Output" },
  })
end)

register_callback_for_filetype({ "go" }, function()
  wk.add({
    { "<leader>C", group = "Go" },
    { "<leader>Cb", ":GoBuild %:h<CR>", desc = "Build" },
    { "<leader>Cc", ":GoCoverage -p<CR>", desc = "Coverage" },
    { "<leader>Ci", ":GoImports<CR>", desc = "Imports" },
    { "<leader>Ct", ":GoTestPkg<CR>", desc = "Run test on package" },
    { "<leader>Cf", ":GoTestFile<CR>", desc = "Run test on file" },
    { "<leader>ch", ":GoAlt<CR>", desc = "Open Test file" },
  })
end)
