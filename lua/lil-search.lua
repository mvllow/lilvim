--- lil-search.lua
--- https://github.com/mvllow/lilvim

--- Setup search.

local use = require('lil-helpers').use

use('nvim-telescope/telescope.nvim')
use('nvim-lua/plenary.nvim')

vim.opt.ignorecase = true
vim.opt.smartcase = true

local opts = { silent = true }
vim.keymap.set('n', '<esc>', ':noh<cr>', opts) -- clear search highlights
vim.keymap.set('n', '*', '*N', opts) -- search word under cursor (keep position)
vim.keymap.set('v', '*', [[y/\V<c-r>=escape(@",'/\')<cr><cr>N]], opts) -- search selection (keep position)

local has_telescope, telescope = pcall(require, 'telescope')
if has_telescope then
	vim.keymap.set('n', '<leader>f', ':Telescope find_files<cr>', opts) -- search files
	vim.keymap.set('n', '<leader>/', ':Telescope live_grep<cr>', opts) -- search text

	telescope.setup({
		defaults = {
			layout_config = {
				horizontal = {
					-- Increase preview width
					preview_width = 0.6,
				},
			},
		},
		pickers = {
			find_files = {
				theme = 'dropdown',
				previewer = false,
				find_command = {
					'fd',
					'--type',
					'f',
					'--hidden',
					'--exclude',
					'.git',
					'--strip-cwd-prefix',
				},
			},
		},
	})
end
