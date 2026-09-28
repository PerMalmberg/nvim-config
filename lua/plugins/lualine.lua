return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "olimorris/codecompanion.nvim",
  },
  config = function()
    local function cc_status()
      local ok, cc = pcall(require, "codecompanion")
      if not ok then
        return ""
      end

      local metadata = _G.codecompanion_chat_metadata
      local chat = cc.last_chat()

      if not metadata or not chat then
        return ""
      end

      local chat_visible = false
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_buf(win) == chat.bufnr then
          chat_visible = true
          break
        end
      end

      if not chat_visible then
        return ""
      end

      local data = metadata[chat.bufnr]
      if not data then
        return ""
      end

      local adapter = data.adapter or {}
      local model = adapter.model or adapter.name or "unknown"
      local cycles = data.cycles or 0
      local tokens = data.tokens or 0
      local tools = data.tools or 0

      return ("󰚩 %s · Cy:%s · Tok:%s · Tool: %d"):format(model, cycles, tokens, tools)
    end

    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "starter" },
        },
        refresh = {
          statusline = 1000,
        },
      },

      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(mode)
              return " " .. mode
            end,
          },
        },

        lualine_b = {
          {
            "branch",
            icon = "",
          },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
          },
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰌵 ",
            },
          },
        },

        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },

        lualine_x = {
          {
            "filetype",
            icon_only = false,
          },
          {
            "encoding",
            fmt = function(value)
              return value == "utf-8" and "󰉿 UTF-8" or value
            end,
          },
          {
            "fileformat",
            symbols = {
              unix = " LF",
              dos = " CRLF",
              mac = " CR",
            },
          },
        },

        lualine_y = {
          cc_status,
        },

        lualine_z = {
          {
            "progress",
            fmt = function(value)
              return "󰔛 " .. value
            end,
          },
          {
            "location",
            fmt = function(value)
              return "󰍎 " .. value
            end,
          },
        },
      },
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = {
        "CodeCompanionChatCreated",
        "CodeCompanionChatClosed",
        "CodeCompanionRequestStarted",
        "CodeCompanionRequestFinished",
        "CodeCompanionInlineStarted",
        "CodeCompanionInlineFinished",
      },
      callback = function()
        vim.schedule(function()
          vim.cmd("redrawstatus")
        end)
      end,
    })
  end,
}
