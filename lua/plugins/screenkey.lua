return {
	"NStefan002/screenkey.nvim",
	dependencies = {
		"folke/which-key.nvim",
	},
	cmd = "Screenkey",
	version = "*",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.register({
			["<leader>u"] = {
				k = { "<cmd>Screenkey<cr>", "Toggle Screenkey" },
			},
		})
	end,
}
