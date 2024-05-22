return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		---@class PluginLspOpts
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"gdscript",
			})

			-- Setuo debugger using default ports as configured in Godot.
			-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#godot-gdscript
			local dap = require("dap")
			dap.adapters.godot = {
				type = "server",
				host = "127.0.0.1",
				port = 6006,
			}

			dap.configurations.gdscript = {
				{
					type = "godot",
					project = "${workspaceFolder}",
					name = "Launch Scene",
					request = "launch",
				},
			}
		end,
	},
}
