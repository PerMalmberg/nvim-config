return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "olimorris/codecompanion.nvim" },
  config = function()
    local cc_status = function()
      local cc = require("codecompanion")

      local meta = _G.codecompanion_chat_metadata
      if not meta then
        return ""
      end

      local chat = cc.last_chat()
      if not chat then
        return ""
      end

      local data = meta[chat.bufnr]

      if not data then
        return ""
      end

      local status = ("󰚩 %s / C:%d T:%d"):format(data.adapter.model, data.cycles, data.tokens)

      return status
    end

    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true,
      },
      sections = {
        lualine_x = {
          cc_status,
          "encoding",
          {
            "fileformat",
            symbols = {
              unix = "Unix (LF)",
              dos = "Win (CRLF)",
              mac = "Mac (CR)",
            },
          },
          "filetype",
        },
      },
    })
  end,
}
