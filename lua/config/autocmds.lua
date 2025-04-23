-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  desc = "Ensures spaces are used on CMake files instead of tabs",
  callback = function(event)
    if event.match == "cmake" then
      vim.o.expandtab = true
      vim.o.tabstop = 2
      vim.o.shiftwidth = 0
    elseif event.match == "json" then
      vim.o.tabstop = 2
      vim.o.shiftwidth = 0
    end
  end,
})
