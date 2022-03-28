--- lil-lsp.lua
--- https://github.com/mvllow/lilvim

--- Setup language servers, diagnostics and formatting.

local use = require('lil-helpers').use

use({
	'neovim/nvim-lspconfig',
	requires = 'folke/lua-dev.nvim',
	config = function()
		local function on_attach(client, bufnr)
			-- Disable lsp-provided formatting in favour of null-ls
			client.resolved_capabilities.document_formatting = false

			local b_opts = { buffer = bufnr, silent = true }
			vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, b_opts)
			vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, b_opts)
			vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, b_opts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, b_opts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, b_opts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, b_opts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, b_opts)
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

		-- Language servers to setup. Servers must be available in your path.
		-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		local servers = {
			'cssls',
			'html',
			'jsonls',
			'rust_analyzer',
			'svelte',
			'tailwindcss',
			'tsserver',
			'volar',
		}

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
			sources = {
				null_ls.builtins.code_actions.xo,
				null_ls.builtins.diagnostics.xo,
				null_ls.builtins.formatting.fish_indent,
				null_ls.builtins.formatting.prettierd.with({
					extra_filetypes = { 'svelte', 'jsonc' },
				}),
				null_ls.builtins.formatting.rustfmt,
				null_ls.builtins.formatting.stylua,
			},
			on_attach = function(client)
				if client.resolved_capabilities.document_formatting then
					vim.api.nvim_create_autocmd('BufWritePre', {
						pattern = '<buffer>',
						callback = function()
							vim.lsp.buf.formatting_sync()
						end,
					})
				end
			end,
		})
	end,
})

local opts = { silent = true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- goto previous diagnostic
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- goto next diagnostic
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts) -- show diagnostic message

vim.diagnostic.config({
	virtual_text = false,
})
