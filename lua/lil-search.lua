--- lil-search.lua
--- https://github.com/mvllow/lilvim
---
--- Setup search.

local use = require('lil-helpers').use

use({
	'nvim-telescope/telescope.nvim',
	requires = 'nvim-lua/plenary.nvim',
	config = function()
		require('telescope').setup({})
	end,
})

-- Case-insensitive search, unless search contains uppercase.
vim.opt.ignorecase = true
vim.opt.smartcase = true

local opts = { silent = true }

-- Clear search highlights.
vim.keymap.set('n', '<esc>', ':noh<cr>', opts)

-- Keep position when searching for word under cursor.
vim.keymap.set('n', '*', '*N', opts)
vim.keymap.set('v', '*', [[y/\V<c-r>=escape(@",'/\')<cr><cr>N]], opts)

vim.keymap.set(
	'n',
	'<leader>f',
	':Telescope find_files find_command=fd,-t,f,-H,-E,.git,--strip-cwd-prefix theme=dropdown previewer=false<cr>',
	opts
)
vim.keymap.set('n', '<leader>/', ':Telescope live_grep<cr>', opts)
vim.keymap.set('n', '<leader>p', ':Telescope commands theme=dropdown<cr>', opts)
