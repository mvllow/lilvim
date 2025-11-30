vim.api.nvim_create_user_command("LilToggle", function(opts)
	LilToggle = require("lil-toggle")
	LilToggle.toggle(opts.args)
end, { nargs = "+", desc = "Toggle things" })
