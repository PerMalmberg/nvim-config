return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local uname = vim.uv.os_uname()
    local is_linux_aarch64 = (uname.sysname == "Linux" and uname.machine == "aarch64")
    -- Don't install clangd on aarch64, use system clangd instead. clangd is not yet available in mason for aarth64.
    if is_linux_aarch64 then
      opts.servers = opts.servers or {}
      opts.servers.clangd = {
        mason = false,
        cmd = { "clangd" },
      }
    end
  end,
}
