--- lil-ui.lua
--- https://github.com/mvllow/lilvim

--- Setup interface elements including colorscheme and statusline.

local helpers = require('lil-helpers')
local plugins = {
	-- TODO: Allow post install hook, eg. :TSUpdate
	'nvim-treesitter/nvim-treesitter',
	'rose-pine/neovim',
}

local function module()
	vim.opt.updatetime = 250
	vim.opt.signcolumn = 'yes'
	vim.opt.laststatus = 3
	vim.opt.statusline = ' %f %M %= %l:%c ♥ '
	vim.opt.shortmess:append('c')

	-- Equally resize splits
	vim.api.nvim_create_autocmd('VimResized', {
		pattern = '*',
		command = 'tabdo wincmd =',
	})

	local has_treesitter, treesitter = pcall(require, 'nvim-treesitter.configs')
	if has_treesitter then
		treesitter.setup({
			ensure_installed = 'maintained',
			ignore_install = { 'haskell' },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end

	local has_rose_pine, rose_pine = pcall(require, 'rose-pine')
	if has_rose_pine then
		rose_pine.setup({ disable_italics = true })
		vim.cmd('colorscheme rose-pine')
	end
end

helpers.setup_module(module, plugins)
