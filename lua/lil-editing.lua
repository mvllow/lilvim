--- lil-editing.lua
--- https://github.com/mvllow/lilvim
---
--- Setup options related to editing.

local use = require('lil-helpers').use

use({
	'echasnovski/mini.comment',
	config = function()
		require('mini.comment').setup()
	end,
})

-- Indentation levels.
vim.opt.tabstop = 4
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

-- Move through wrapped lines.
vim.keymap.set({ 'n', 'v' }, 'j', 'gj', {
	desc = 'Move down wrapped lines',
	silent = true,
})
vim.keymap.set({ 'n', 'v' }, 'k', 'gk', {
	desc = 'Move up wrapped lines',
	silent = true,
})

-- Bubble lines.
vim.keymap.set('n', '<c-j>', ':m .+1<cr>==', {
	desc = 'Bubble line down',
	silent = true,
})
vim.keymap.set('n', '<c-k>', ':m .-2<cr>==', {
	desc = 'Bubble line up',
	silent = true,
})
vim.keymap.set('v', '<c-j>', ":m '>+1<cr>gv=gv", {
	desc = 'Bubble line down',
	silent = true,
})
vim.keymap.set('v', '<c-k>', ":m '<-2<cr>gv=gv", {
	desc = 'Bubble line up',
	silent = true,
})

-- Keep selection after indenting.
vim.keymap.set('v', '<', '<gv', { desc = 'Dedent selection', silent = true })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent selection', silent = true })

-- Indent file contents.
vim.keymap.set('n', '=', 'mxggVG=`x', {
	desc = 'Indent file contents',
	silent = true,
})

-- Substitute current word.
vim.keymap.set('n', 'S', ':%s/<c-r><c-w>//g<left><left>', {
	desc = 'Substitute current word',
})

-- Goto previous position.
vim.keymap.set('n', 'go', '<c-o>', {
	desc = 'Goto previous position',
	silent = true,
})

-- Goto previously focused buffer.
vim.keymap.set('n', 'gp', '<c-^>', {
	desc = 'Goto previously focused buffer',
	silent = true,
})

-- Goto matching pair.
vim.keymap.set({ 'n', 'v' }, 'gm', '%', {
	desc = 'Goto matching pair',
	silent = true,
})
