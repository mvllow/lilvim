--- lil-lsp.lua
--- https://github.com/mvllow/lilvim
---
--- Setup language servers, diagnostics and formatting.

local use = require('lil-helpers').use

use({
	'neovim/nvim-lspconfig',
	requires = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',
	},
	config = function()
		require('mason').setup()
		require('mason-tool-installer').setup({})
		require('mason-lspconfig').setup()

		local function on_attach(_, bufnr)
			local opts = { buffer = bufnr, silent = true }
			vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
			vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- Improve compatibility with nvim-cmp completions.
		local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
		if has_cmp_nvim_lsp then
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		end

		-- Automatically setup servers installed via Mason.
		-- @usage :MasonInstall <server>
		-- @example :MasonInstall denols tsserver
		require('mason-lspconfig').setup_handlers({
			function(server_name)
				require('lspconfig')[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,

			-- Remove ".git" from denols and tsserver root detection to prevent
			-- overlap.
			-- https://deno.land/manual@v1.28.3/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
			['denols'] = function()
				require('lspconfig').denols.setup({
					on_attach = on_attach,
					root_dir = require('lspconfig').util.root_pattern(
						'deno.json',
						'deno.jsonc'
					),
				})
			end,

			['tsserver'] = function()
				require('lspconfig').tsserver.setup({
					on_attach = on_attach,
					root_dir = require('lspconfig').util.root_pattern(
						'package.json'
					),
				})
			end,
		})
	end,
})

use({
	'jose-elias-alvarez/null-ls.nvim',
	requires = {
		'nvim-lua/plenary.nvim',
		'jayp0521/mason-null-ls.nvim',
	},
	config = function()
		-- TIP: Format on save is disabled by default and instead mapped to
		-- <space><space>. To enable format on save, pass the format_on_save
		-- function to the null-ls on_attach below.
		local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
		local function format_on_save(client, bufnr)
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
		end

		-- Automatically setup linters/formatters installed via Mason.
		-- @usage :NullLsInstall <source>
		-- @example :NullLsInstall prettierd
		require('mason-null-ls').setup({ automatic_setup = true })
		require('null-ls').setup({
			-- Edit source defaults
			sources = {
				require('null-ls').builtins.formatting.prettierd.with({
					extra_filetypes = { 'jsonc', 'astro', 'svelte' },
				}),
			},
			-- Uncomment the below to enable format on save.
			-- on_attach = format_on_save,
		})
		require('mason-null-ls').setup_handlers()
	end,
})

local opts = { silent = true }

vim.keymap.set('n', '<space><space>', vim.lsp.buf.format, opts)
