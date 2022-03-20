--- lil-search.lua
--- https://github.com/mvllow/lilvim

--- Setup search.

local helpers = require('lil-helpers')
local plugins = {
	'nvim-telescope/telescope.nvim',
	'nvim-lua/plenary.nvim',
}

local function module()
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
end

helpers.setup_module(module, plugins)
