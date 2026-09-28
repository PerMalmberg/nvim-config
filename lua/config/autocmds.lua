-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local two_space_filetypes = {
  cmake = true,
  json = true,
  lua = true,
  markdown = true,
  yaml = true,
}

vim.api.nvim_create_autocmd("FileType", {
  desc = "Set file formatting options",
  callback = function(event)
    -- Use buffer-local options so opening a file does not change other buffers.
    local buffer_options = vim.bo[event.buf]

    buffer_options.tabstop = two_space_filetypes[event.match] and 2 or 4
    buffer_options.shiftwidth = 0 -- Use 'tabstop'
    buffer_options.expandtab = true -- Fill with spaces
  end,
})
