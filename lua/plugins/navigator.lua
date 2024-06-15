return {
	"ray-x/navigator.lua",
	dependencies = {
		{ "hrsh7th/nvim-cmp" },
		{ "nvim-treesitter/nvim-treesitter" },
		{ "ray-x/guihua.lua",               run = "cd lua/fzy && make" },
		{
			"ray-x/go.nvim",
			event = { "CmdlineEnter" },
			ft = { "go", "gomod" },
			build = ':lua require("go.install").update_all_sync()',
		},
		{
			"ray-x/lsp_signature.nvim", -- Show function signature when you type
			event = "VeryLazy",
			config = function()
				require("lsp_signature").setup()
			end,
		},
	},
	config = function()
		require("go").setup()
		require("navigator").setup({
			lsp_signature_help = true, -- enable ray-x/lsp_signature
			lsp = { format_on_save = true },
			mason = true,     -- Use Mason to install LSPs
		})

		-- Disable nvim-cmp and nvim-autopairs in navigator floating windows
		-- https://github.com/ray-x/navigator.lua?tab=readme-ov-file#work-with-nvim-cmp-and-nvim-autopairs
		vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
		vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")
	end,
}
