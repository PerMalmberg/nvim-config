-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					preview_width = 0.65,
					horizontal = {
						size = {
							width = "95%",
							height = "95%",
						},
					},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
					},
				},
				mappings = {
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
			},
		})

		-- Enable telescope fzf native, if installed
		pcall(require("telescope").load_extension, "fzf")

		local builtin = require("telescope.builtin")
		-- See `:help telescope.builtin`
		vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find()
		end, { desc = "[/] Fuzzily search in current buffer]" })

		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>co", builtin.lsp_outgoing_calls, { desc = "Outgoing Calls (LSP)" })
		vim.keymap.set("n", "<leader>ci", builtin.lsp_incoming_calls, { desc = "Incoming Calls (LSP)" })
		vim.keymap.set("n", "<leader>cw", builtin.lsp_workspace_symbols, { desc = "Workspace Symbols (LSP)" })
		vim.keymap.set("n", "<leader>cd", builtin.lsp_document_symbols, { desc = "Document Symbols (LSP)" })
		-- vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Goto [d]efinition of word (LSP)" })
		-- vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "Goto [t]ype definition (LSP)" })

		vim.keymap.set("n", "st", ":TodoTelescope<CR>", { noremap = true })
	end,
}
