--- lil-ui.lua
--- https://github.com/mvllow/lilvim
---
--- Setup interface elements including colorscheme and statusline.

local use = require('lil-helpers').use

use({
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup({
			-- Install treesitter parsers for all languages.
			ensure_installed = 'all',

			-- Enable treesitter syntax highlight groups.
			highlight = { enable = true },
		})
	end,
})

use({
	'rose-pine/neovim',
	as = 'rose-pine',
	config = function()
		require('rose-pine').setup({
			disable_italics = true,
		})
		vim.cmd('colorscheme rose-pine')
	end,
})

vim.diagnostic.config({
	-- Disable inline messages.
	virtual_text = false,
})

-- Use lil dots for diagnostic signs.
local signs = { 'Error', 'Warn', 'Hint', 'Info' }
for _, type in pairs(signs) do
	local hl = string.format('DiagnosticSign%s', type)
	vim.fn.sign_define(hl, { text = '●', texthl = hl, numhl = hl })
end

-- Use block cursor in all modes.
vim.opt.guicursor = ''

-- Always show sign column.
vim.opt.signcolumn = 'yes'

-- Time in ms to update vim events.
vim.opt.updatetime = 250

-- Opioniated global statusline.
vim.opt.statusline = ' %f %m %= %l:%c ♥ '
vim.opt.laststatus = 3

-- Shorter vim messages.
vim.opt.shortmess:append('c')

-- Create highlight group and assign to the first character over 80 columns.
-- Useful reference to wrap lines. Use the `gw` motion to wrap a visual
-- selection at 80 columns.
vim.cmd('hi LilColorColumn cterm=reverse gui=reverse')
vim.fn.matchadd('LilColorColumn', '\\%81v', 100)

-- Equally resize buffer splits.
vim.api.nvim_create_autocmd('VimResized', {
	command = 'tabdo wincmd =',
})

-- Toggle built-in file explorer, Netrw. If using the lil-extras module, this
-- will be replaced with nvim-tree.
vim.keymap.set(
	'n',
	'<leader>e',
	'<cmd>Ex<cr>',
	{ silent = true, desc = 'Toggle file tree' }
)
