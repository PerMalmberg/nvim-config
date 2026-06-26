return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    if vim.loop.os_uname().sysname == "Windows_NT" then
      require("nvim-treesitter.install").compilers = { "clang" }
    end
  end,
}
