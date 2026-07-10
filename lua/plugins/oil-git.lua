return {
  "malewicz1337/oil-git.nvim",
  dependencies = { "stevearc/oil.nvim" },
  opts = {
    debounce_ms = 50,
    show_file_highlights = true,
    show_directory_highlights = true,
    show_file_symbols = true,
    show_directory_symbols = true,
    show_ignored_files = false, -- Show ignored file status
    show_ignored_directories = false, -- Show ignored directory status
    show_branch = true, -- Show current Git branch in oil buffers
    branch_format = " %s", -- Format string for branch display
    symbol_position = "eol", -- "eol", "signcolumn", or "none"
    can_use_signcolumn = nil, -- Optional callback(bufnr): nil|bool|string
    ignore_gitsigns_update = false, -- Ignore GitSignsUpdate events (fallback for flickering)
    debug = false, -- false, "minimal", or "verbose"

    symbols = {
      file = {
        added = "+",
        modified = "~",
        renamed = "->",
        deleted = "D",
        copied = "C",
        conflict = "!",
        untracked = "?",
        ignored = "o",
      },
      directory = {
        added = "*",
        modified = "*",
        renamed = "*",
        deleted = "*",
        copied = "*",
        conflict = "!",
        untracked = "*",
        ignored = "o",
      },
    },

    -- Colors (only applied if highlight groups don't exist)
    highlights = {
      OilGitAdded = { fg = "#a6e3a1" },
      OilGitModifiedStaged = { fg = "#f9e2af" },
      OilGitModifiedUnstaged = { fg = "#e5c890" },
      OilGitBranch = { fg = "#89b4fa" },
      OilGitRenamed = { fg = "#cba6f7" },
      OilGitDeleted = { fg = "#f38ba8" },
      OilGitCopied = { fg = "#cba6f7" },
      OilGitConflict = { fg = "#fab387" },
      OilGitUntracked = { fg = "#89b4fa" },
      OilGitIgnored = { fg = "#6c7086" },
    },
  },
  config = function(_, opts)
    require("oil-git").setup(opts)
  end,
}
