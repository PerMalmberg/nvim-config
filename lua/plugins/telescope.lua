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
		-- vim.keymap.set("n", "<leader>sS", builtin.git_status, { desc = "Git Status" })
		-- vim.keymap.set("n", "<Leader>sn", require("telescope").extensions.notify.notify, { silent = true })

		vim.keymap.set("n", "st", ":TodoTelescope<CR>", { noremap = true })
		-- vim.keymap.set("n", "<Leader><tab>", builtin.commands, { noremap = false })
		-- vim.keymap.set("n", "<leader>sm", ":Telescope harpoon marks<CR>", { desc = "Harpoon [M]arks" })
	end,
}
