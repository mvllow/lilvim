--- lil-editing.lua
--- https://github.com/mvllow/lilvim
---
--- Setup options related to editing.

local use = require('lil-helpers').use

use('editorconfig/editorconfig-vim')

use({
	'numToStr/Comment.nvim',
	requires = {
		'nvim-treesitter/nvim-treesitter',
		'JoosepAlviste/nvim-ts-context-commentstring',
	},
	config = function()
		require('nvim-treesitter.configs').setup({
			-- Get comment string from treesitter. Useful for files with multiple
			-- languages, e.g. html `style` tags.
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
		})

		require('Comment').setup({
			pre_hook = require(
				'ts_context_commentstring.integrations.comment_nvim'
			).create_pre_hook(),
		})
	end,
})

-- Indentation levels.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Persistent undo between sessions.
vim.opt.undofile = true

-- Natural split directions.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Start scrolling before reaching screen edge.
vim.opt.scrolloff = 3

-- Continue wrapped lines with matching indentation.
vim.opt.breakindent = true

-- Stop 'o' continuing comments.
vim.api.nvim_create_autocmd('BufEnter', {
	command = 'setlocal formatoptions-=o',
})

-- Temporarily highlight yanked text.
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Move through wrapped lines.
vim.keymap.set(
	{ 'n', 'v' },
	'j',
	'gj',
	{ silent = true, desc = 'Move down wrapped lines' }
)
vim.keymap.set(
	{ 'n', 'v' },
	'k',
	'gk',
	{ silent = true, desc = 'Move up wrapped lines' }
)

-- Bubble lines.
vim.keymap.set(
	'n',
	'<c-j>',
	':m .+1<cr>==',
	{ silent = true, desc = 'Bubble line down' }
)
vim.keymap.set(
	'n',
	'<c-k>',
	':m .-2<cr>==',
	{ silent = true, desc = 'Bubble line up' }
)
vim.keymap.set(
	'v',
	'<c-j>',
	":m '>+1<cr>gv=gv",
	{ silent = true, desc = 'Bubble line down' }
)
vim.keymap.set(
	'v',
	'<c-k>',
	":m '<-2<cr>gv=gv",
	{ silent = true, desc = 'Bubble line up' }
)

-- Keep selection after indenting.
vim.keymap.set('v', '<', '<gv', { silent = true, desc = 'Dedent selection' })
vim.keymap.set('v', '>', '>gv', { silent = true, desc = 'Indent selection' })

-- Indent file contents.
vim.keymap.set(
	'n',
	'=',
	'mxggVG=`x',
	{ silent = true, desc = 'Indent file contents' }
)

-- Substitute current word.
vim.keymap.set(
	'n',
	'S',
	':%s/<c-r><c-w>//g<left><left>',
	{ desc = 'Substitute current word' }
)

-- Goto previous position.
vim.keymap.set(
	'n',
	'go',
	'<c-o>',
	{ silent = true, desc = 'Goto previous position' }
)

-- Goto previously focused buffer.
vim.keymap.set(
	'n',
	'gp',
	'<c-^>',
	{ silent = true, desc = 'Goto previously focused buffer' }
)

-- Goto matching pair.
vim.keymap.set(
	{ 'n', 'v' },
	'gm',
	'%',
	{ silent = true, desc = 'Goto matching pair' }
)

-- Goto diagnostic.
vim.keymap.set(
	'n',
	']d',
	vim.diagnostic.goto_next,
	{ silent = true, desc = 'Goto next diagnostic' }
)
vim.keymap.set(
	'n',
	'[d',
	vim.diagnostic.goto_prev,
	{ silent = true, desc = 'Goto previous diagnostic' }
)

-- Show line diagnostics.
vim.keymap.set(
	'n',
	'gl',
	vim.diagnostic.open_float,
	{ silent = true, desc = 'Show line diagnostics' }
)
