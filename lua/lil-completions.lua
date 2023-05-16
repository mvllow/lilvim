--- lil-completions.lua
--- https://github.com/mvllow/lilvim
---
--- Setup completions and snippets.

local use = require("lil-helpers").use

use({
	"echasnovski/mini.completion",
	config = function()
		require("mini.completion").setup()
	end,
})

-- Number of items to show in popup menu.
vim.opt.pumheight = 3

local keys = {
	["cr"] = vim.api.nvim_replace_termcodes("<cr>", true, true, true),
	["c-y"] = vim.api.nvim_replace_termcodes("<c-y>", true, true, true),
	["c-y_cr"] = vim.api.nvim_replace_termcodes("<c-y><cr>", true, true, true),
}

vim.keymap.set("i", "<cr>", function()
	if vim.fn.pumvisible() ~= 0 then
		-- If popup is visible, confirm selected item or add new line otherwise
		local item_selected = vim.fn.complete_info()["selected"] ~= -1
		return item_selected and keys["c-y"] or keys["c-y_cr"]
	else
		-- If popup is not visible, use plain `<cr>`.
		return keys["cr"]
	end
end, { expr = true })

vim.keymap.set("i", "<tab>", 'pumvisible() ? "<c-n>" : "<tab>"', { expr = true })
vim.keymap.set("i", "<s-tab>", 'pumvisible() ? "<c-p>" : "<s-tab>"', { expr = true })
