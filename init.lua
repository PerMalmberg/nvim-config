-- bootstrap lazy.nvim, LazyVim and your plugins

if vim.fn.has("win32") == 1 then
  vim.o.shell = "pwsh"
  vim.o.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
end

vim.o.shellquote = ""
vim.o.shellxquote = ""

require("config.lazy")
require("config.options")
vim.cmd("colorscheme gruvdark")

--- Confugure the ctags-lsp server
--- Requires ctags and ctags-lsp to be installed and in your PATH
--- https://github.com/netmute/ctags-lsp/blob/v0.11.0/README.md
--- https://github.com/universal-ctags/ctags#how-to-build-and-install
vim.lsp.config("ctags_lsp", {
  cmd = { "ctags-lsp" },
  filetypes = { "cpp", "c" }, -- Change this to the language(s) nvim should attach the LSP to
})
vim.lsp.enable("ctags_lsp")
