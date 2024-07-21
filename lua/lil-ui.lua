---
--- lil-ui.lua
--- https://github.com/mvllow/lilvim
---
--- Setup treesitter and interface.
---
--- @commands
--- :TS<tab>
---   Autocomplete all available commands
---

vim.opt.guicursor = ""
vim.opt.signcolumn = "yes"

vim.api.nvim_create_autocmd("VimResized", {
	command = "tabdo wincmd =",
	desc = "Balance windows",
})

MiniDeps.add({
	source = "nvim-treesitter/nvim-treesitter",
	hooks = {
		post_checkout = function()
			vim.cmd("TSUpdate")
		end,
	},
})
require("nvim-treesitter.configs").setup({
	-- Install missing parsers when entering new buffers
	auto_install = true,
	ensure_installed = { "lua", "vimdoc", "markdown" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = {
		enable = true,
		disable = { "ruby" },
	},
})
