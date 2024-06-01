return {
	{
		"leoluz/nvim-dap-go",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		opts = function(plugin, opts)
			local windows = vim.fn.has("win32") == 1

			if windows then
				local dapgo = require("dap-go")
				dapgo.setup({
					delve = {
						-- As per documentation in nvim-dap-go and nvim-dap (where the actual issue arrises) detached must be false on windows
						-- so we pass that in here when running windows. This gets merged via vim.tbl_deep_extend("force", ...) in dapgo.setup.
						detached = false,
						hide = true, -- Hide the window
					},
				})
			end
		end,
	},
}
