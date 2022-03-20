--- lil-completions.lua
--- https://github.com/mvllow/lilvim

--- Setup completions and snippets.

local helpers = require('lil-helpers')
local plugins = {
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'L3MON4D3/LuaSnip',
}

local function module()
	vim.opt.completeopt = 'menu,menuone,noselect'
	vim.opt.pumheight = 3

	local has_cmp, cmp = pcall(require, 'cmp')
	if has_cmp then
		cmp.setup({
			snippet = {
				expand = function(args)
					local has_luasnip, luasnip = pcall(require, 'luasnip')
					if has_luasnip then
						luasnip.lsp_expand(args.body)
					end
				end,
			},
			mapping = {
				['<c-space>'] = cmp.mapping.complete(),
				['<cr>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
				['<tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end,
				['<s-tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end,
			},
			sources = {
				{ name = 'nvim_lsp' },
			},
		})
	end
end

helpers.setup_module(module, plugins)
