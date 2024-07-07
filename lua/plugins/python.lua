return {
	"mfussenegger/nvim-dap-python",
	config = function()
		local dappy = require("dap-python")
		dappy.setup(vim.fn.expand("$HOME/.virtualenvs/debugpy/bin/python"))
	end,
}
