--- lil-lsp.lua
--- https://github.com/mvllow/lilvim

--- Setup language servers, diagnostics and formatting.

local use = require('lil-helpers').use

use({
	'neovim/nvim-lspconfig',
	requires = {
		'folke/neodev.nvim',
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',
	},
	config = function()
		require('neodev').setup()
		require('mason').setup()
		require('mason-tool-installer').setup({})

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
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		end

		-- Automatically setup servers installed via `:MasonInstall`
		require('mason-lspconfig').setup_handlers({
			function(server_name)
				require('lspconfig')[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
		})
	end,
})
use({
	'jose-elias-alvarez/null-ls.nvim',
	requires = 'nvim-lua/plenary.nvim',
	config = function()
		local null_ls = require('null-ls')

		-- TODO(user): Add sources
		-- Source cmd must be available in your path. Try `:MasonInstall stylua`.
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
		local sources = {
			null_ls.builtins.formatting.prettierd.with({
				-- Add additional filetypes to be formatted with prettier.
				-- Note that in `/ftplugin/json.lua` we override the json
				-- filetype to be jsonc.
				extra_filetypes = { 'jsonc' },
			}),
			null_ls.builtins.formatting.stylua,
		}

		local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				-- Format on save
				if client.supports_method('textDocument/formatting') then
					vim.api.nvim_clear_autocmds({
						group = augroup,
						buffer = bufnr,
					})
					vim.api.nvim_create_autocmd('BufWritePre', {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
	end,
})
