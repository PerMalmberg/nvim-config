return {
  "olimorris/codecompanion.nvim",
  --  version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- local log = require("codecompanion.utils.log")
    require("codecompanion").setup({
      opts = {
        log_level = "DEBUG",
      },
      interactions = {
        chat = {
          tools = {
            ["run_command"] = {
              opts = {
                require_approval_before = true,
              },
            },
          },
          adapter = "litellm_router",
        },
        inline = {
          adapter = "litellm_router",
        },
        cmd = {
          adapter = "litellm_router",
        },
      },
      adapters = {
        http = {
          opts = {
            show_presets = false, -- Hide default adapters
            hidden = {
              auggie_cli = true,
              cagent = true,
              claude_code = true,
              cline_cli = true,
              codex = true,
              copilot_acp = true,
              cursor_cli = true,
              gemini_cli = true,
              goose = true,
              kimi_cli = true,
              kiro = true,
              mistral_vibe = true,
              opencode = true,
            },
          },
          litellm_router = function()
            local api_prefix = "/v1"
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                api_key = os.getenv("LITEROUTER_API_KEY"),
                url = "https://litellm.internal-ai-models.flexeraeng.com",
                models_endpoint = api_prefix .. "/models",
                chat_url = api_prefix .. "/chat/completions",
              },
              schema = {
                model = {
                  default = "GPT-6 Luna Bedrock",
                },
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = "litellm_router",
        },
        inline = {
          adapter = "litellm_router",
        },
        agent = {
          adapter = "litellm_router",
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
      },
    })
  end,
}
