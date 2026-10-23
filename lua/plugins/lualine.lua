return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "olimorris/codecompanion.nvim",
  },
  config = function()
    local working_chats = {}
    local active_requests = {}

    local is_recording = function()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      end
      return "Rec to: " .. reg
    end

    local function cc_status_parts()
      local ok, cc = pcall(require, "codecompanion")
      if not ok then
        return "", ""
      end

      local metadata = _G.codecompanion_chat_metadata
      local chat = cc.last_chat()
      if not metadata or not chat then
        return "", ""
      end

      local chat_visible = false
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_buf(win) == chat.bufnr then
          chat_visible = true
          break
        end
      end

      local data = metadata[chat.bufnr]
      if not chat_visible or not data then
        return "", ""
      end

      local adapter = data.adapter or {}
      local model = adapter.model or adapter.name or "unknown"
      local cycles = data.cycles or 0
      local tokens = data.tokens or 0
      local tools = data.tools or 0
      local working = working_chats[chat.bufnr] or active_requests[chat.bufnr]

      return ("󰚩 %s (%s) · Cy:%s · Tok:%s · Tool: %d"):format(model, adapter.name or "", cycles, tokens, tools),
        working and " · ⟳ Agent working" or ""
    end

    local function cc_status()
      local status = cc_status_parts()
      return status
    end

    local function cc_working_status()
      local _, indicator = cc_status_parts()
      return indicator
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
          { is_recording, color = { fg = "#ff0000" } },
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
          { cc_working_status, color = { fg = "#ff69b4" } },
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
        "CodeCompanionChatClosed",
        "CodeCompanionChatSubmitted",
        "CodeCompanionChatDone",
        "CodeCompanionChatStopped",
        "CodeCompanionRequestStarted",
        "CodeCompanionRequestFinished",
        "CodeCompanionInlineStarted",
        "CodeCompanionInlineFinished",
      },
      callback = function(args)
        local data = args.data or {}
        local bufnr = data.bufnr or data.buf or args.buf
        local event = args.match

        if bufnr then
          if event == "CodeCompanionChatSubmitted" then
            working_chats[bufnr] = true
          elseif
            event == "CodeCompanionChatDone"
            or event == "CodeCompanionChatStopped"
            or event == "CodeCompanionChatClosed"
          then
            working_chats[bufnr] = nil
            active_requests[bufnr] = nil
          elseif event == "CodeCompanionRequestStarted" then
            active_requests[bufnr] = true
          elseif event == "CodeCompanionRequestFinished" then
            active_requests[bufnr] = nil
          elseif event == "CodeCompanionInlineStarted" then
            active_requests[bufnr] = true
          elseif event == "CodeCompanionInlineFinished" then
            active_requests[bufnr] = nil
          end
        end

        vim.schedule(function()
          vim.cmd("redrawstatus")
        end)
      end,
    })
  end,
}
