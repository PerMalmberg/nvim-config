return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    if vim.fn.has("win32") == "Windows_NT" then
      require("nvim-treesitter.install").compilers = { "cl.exe" }
    end
  end,
}
