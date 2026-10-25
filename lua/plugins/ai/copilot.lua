return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "copilotlsp-nvim/copilot-lsp",
  },
  config = function()
    require("copilot").setup({
      logger = {
        file = vim.fn.stdpath("log") .. "/copilot-lua.log",
        file_log_level = vim.log.levels.OFF,
        print_log_level = vim.log.levels.OFF,
        trace_lsp = "off", -- "off" | "debug" | "verbose"
        trace_lsp_progress = false,
        log_lsp_messages = false,
      },
    })
  end,
}
