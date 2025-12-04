--- lil-stats
vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
	group = vim.api.nvim_create_augroup("LilStatsFile", { clear = true }),
	callback = function()
		LilStats = require("lil-stats")
		LilStats.get_file_stats()
	end
})

--- lil-toggle
vim.api.nvim_create_user_command("LilToggle", function(opts)
	LilToggle = require("lil-toggle")
	LilToggle.toggle(opts.args)
end, { nargs = "+", desc = "Toggle things" })
