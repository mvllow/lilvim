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
vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3

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

local opts = { silent = true }

-- Move through wrapped lines.
vim.keymap.set({ 'n', 'v' }, 'j', 'gj', opts)
vim.keymap.set({ 'n', 'v' }, 'k', 'gk', opts)

-- Bubble lines.
vim.keymap.set('n', '<c-j>', ':m .+1<cr>==', opts)
vim.keymap.set('n', '<c-k>', ':m .-2<cr>==', opts)
vim.keymap.set('v', '<c-j>', ":m '>+1<cr>gv=gv", opts)
vim.keymap.set('v', '<c-k>', ":m '<-2<cr>gv=gv", opts)

-- Keep selection after indenting.
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Indent file contents.
vim.keymap.set('n', '=', 'mxggVG=`x', opts)

-- Substitute current word.
vim.keymap.set('n', 'S', ':%s/<c-r><c-w>//g<left><left>')

-- Goto previous position.
vim.keymap.set('n', 'go', '<c-o>', opts)

-- Goto previously focused buffer.
vim.keymap.set('n', 'gp', '<c-^>', opts)

-- Goto matching pair.
vim.keymap.set({ 'n', 'v' }, 'gm', '%', opts)

-- Goto diagnostic.
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)

-- Show line diagnostics.
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
