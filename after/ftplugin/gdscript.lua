-- Setup language server using default port as configured in Godot.
local fs, fn = vim.fs, vim.fn
local port = os.getenv("GDSCRIPT_PORT") or "6005"
local cmd = vim.lsp.rpc.connect("127.0.0.1", tonumber(port))
local pipe

if fn.has("win32") then
	pipe = [[\\.\pipe\godot.pipe]]
else
	pipe = fs.joinpath(fn.stdpath("run")[1], "/path/to/godot.pipe")
end

vim.lsp.start({
	name = "Godot",
	cmd = cmd,
	root_dir = fs.dirname(fs.find({ "project.godot", ".git" }, { upward = true })[1]),
	on_attach = function(client, bufnr)
		print("Started godot lsp via ", pipe)
	end,
})
