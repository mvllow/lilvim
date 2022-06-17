--- lil-extras.lua
--- https://github.com/mvllow/lilvim

--- Setup not so lil enhancements.

local use = require('lil-helpers').use

use({
	'kyazdani42/nvim-tree.lua',
	config = function()
		require('nvim-tree').setup({
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			filters = {
				-- Hide ".git" folder
				custom = { '.git$' },
			},
			git = {
				-- Do not hide gitignored files
				ignore = false,
			},
			renderer = {
				icons = {
					-- Do not show tree icons
					show = {
						file = false,
						folder = false,
						folder_arrow = false,
						git = false,
					},
				},
			},
			view = {
				mappings = {
					list = {
						-- Replace destructive default with trash program
						-- E.g. https://github.com/sindresorhus/trash-cli
						{ key = 'd', action = 'trash' },
						{ key = 'D', action = 'remove' },
					},
				},
				side = 'right',
			},
		})
	end,
})
use({
	'nvim-telescope/telescope.nvim',
	config = function()
		require('telescope').setup({
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
					find_command = { 'fd', '-t', 'f', '--strip-cwd-prefix' },
				},
			},
		})
	end,
})

local opts = { silent = true }
vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<cr>', opts)
vim.keymap.set('n', '<leader>f', ':Telescope find_files<cr>', opts)
vim.keymap.set('n', '<leader>/', ':Telescope live_grep<cr>', opts)
