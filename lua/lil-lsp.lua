--- lil-lsp.lua
--- https://github.com/mvllow/lilvim
---
--- Setup language servers, diagnostics and formatting.

local use = require("lil-helpers").use

use({
	"neovim/nvim-lspconfig",
	requires = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()

		local function on_attach(_, bufnr)
			vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, {
				desc = "Signature help",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {
				desc = "Code actions",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {
				desc = "Rename symbol",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {
				desc = "Documentation",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
				desc = "Goto declaration",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
				desc = "Goto definition",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {
				desc = "Goto type definition",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
				desc = "Goto implementation",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {
				desc = "Goto references",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, {
				desc = "Diagnostics",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
				desc = "Next diagnostic",
				buffer = bufnr,
				silent = true,
			})
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
				desc = "Previous diagnostic",
				buffer = bufnr,
				silent = true,
			})
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- Automatically setup servers installed via Mason.
		-- @usage :MasonInstall <server>
		-- @example :MasonInstall denols tsserver
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,

			-- Remove ".git" from denols and tsserver root detection to prevent
			-- overlap.
			-- https://deno.land/manual@v1.28.3/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
			["denols"] = function()
				require("lspconfig").denols.setup({
					on_attach = on_attach,
					root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
				})
			end,
			["tsserver"] = function()
				require("lspconfig").tsserver.setup({
					on_attach = on_attach,
					root_dir = require("lspconfig").util.root_pattern("package.json"),
				})
			end,
		})
	end,
})

use({
	"jose-elias-alvarez/null-ls.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		-- TIP: Format on save is disabled by default and instead mapped to
		-- <space><space>. To enable format on save, pass the format_on_save
		-- function to the null-ls on_attach below.
		local lsp_formatting = vim.api.nvim_create_augroup("LspFormatting", {})
		local function format_on_save(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = lsp_formatting, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = lsp_formatting,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
							filter = function(lsp_client)
								-- Use null-ls for all formatting.
								return lsp_client.name == "null-ls"
							end,
						})
					end,
				})
			end
		end

		-- Setup linters and formatters.
		-- @usage :MasonInstall <source>
		-- @example :MasonInstall stylua prettierd
		require("null-ls").setup({
			sources = {
				require("null-ls").builtins.formatting.stylua,
				require("null-ls").builtins.formatting.prettierd.with({
					extra_filetypes = { "astro", "svelte" },
				}),
			},
			-- Uncomment the below to enable format on save.
			-- on_attach = format_on_save,
		})
	end,
})

vim.keymap.set("n", "<space><space>", vim.lsp.buf.format, {
	desc = "Format file",
	silent = true,
})
