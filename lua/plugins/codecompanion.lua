return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    "ravitemer/mcphub.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          -- MCP Tools
          make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true, -- Show tool results directly in chat buffer
          format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = false, -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true, -- Add MCP prompts as /slash commands
        },
      },
    },
    interactions = {
      chat = {
        tools = {
          ["run_command"] = {
            opts = {
              require_approval_before = false,
            },
          },
        },
      },
    },
    rules = {
      frontend_dev_setup = {
        description = "Frontend - Dev Setup",
        files = {
          ".github/agents/dev-setup.agent.md",
        },
      },
      frontend_analyzer = {
        description = "Frontend - Analyzer",
        files = {
          ".github/agents/dependency-analyzer.agent.md",
        },
      },
      frontend_validator = {
        description = "Frontend - Validator",
        files = {
          ".github/agents/dependency-validator.agent.md",
        },
      },
      frontend_finalizer = {
        description = "Frontend - Finalizer",
        files = {
          ".github/agents/dependency-finalizer.agent.md",
        },
      },
      opts = {
        chat = {
          autoload = { "default" },
          enabled = true,
        },
      },
    },
  },
}
