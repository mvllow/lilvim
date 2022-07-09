--- lil-lsp.lua
--- https://github.com/mvllow/lilvim

--- Setup language servers, diagnostics and formatting.

local use = require('lil-helpers').use

use({
	'neovim/nvim-lspconfig',
	requires = 'folke/lua-dev.nvim',
	config = function()
		local function on_attach(_, bufnr)
			local opts = { buffer = bufnr, silent = true }
			vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- Improve compatibility with nvim-cmp completions
		local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
		if has_cmp_nvim_lsp then
			capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
		end

		local lspconfig = require('lspconfig')
		lspconfig.sumneko_lua.setup(require('lua-dev').setup({
			lspconfig = {
				on_attach = on_attach,
				capabilities = capabilities,
			},
		}))

		-- TODO(user): Add language servers
		-- Servers must be available in your path.
		-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		local servers = {}
		for _, server in ipairs(servers) do
			lspconfig[server].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end
	end,
})
use({
	'jose-elias-alvarez/null-ls.nvim',
	requires = 'nvim-lua/plenary.nvim',
	config = function()
		local null_ls = require('null-ls')
		null_ls.setup({
			-- TODO(user): Add sources
			-- Source cmd must be available in your path.
			-- https:// https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
			sources = {
				null_ls.builtins.formatting.stylua,
			},
			on_attach = function(client, bufnr)
				if client.supports_method('textDocument/formatting') then
					vim.api.nvim_create_autocmd('BufWritePre', {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format()
						end,
					})
				end
			end,
		})
	end,
})
