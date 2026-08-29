---@tag lil-lsp
---@signature
---@text Features:
---
--- - Configure language servers
--- - Configure diagnostics
---
--- NOTE: Server executables must be available in your |runtimepath|.
---
--- Commands ~
---
--- - `:checkhealth lsp` : Show current LSP status
--- - `:OrganiseImports` : Organise imports in supported files
---
--- Keymaps ~
---
--- - `gO`         : Document symbol
--- - `gra`        : Code action
--- - `gri`        : Implementation
--- - `grn`        : Rename
--- - `grr`        : References
--- - `grt`        : Type definition
--- - `grx`        : Code lens
--- - `gq{motion}` : Format file
--- - `gg`         : Format visual selection
--- - `K`          : Hover (documentation)
--- - `<C-]>`      : Goto definition
--- - `]d`         : Goto next diagnostic
--- - `]D`         : Goto last diagnostic
--- - `[d`         : Goto previous diagnostic
--- - `[D`         : Goto first diagnostic
--- - `<C-w>d`     : Show line diagnostics
--- - `<C-s>`      : Signature help in *insert mode*
---
--- See `:help lsp-defaults` for more.
---
--- Options ~
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
vim.o.signcolumn = "yes" -- always show sign column (reduce layout shift)
--minidoc_afterlines_end

-- Configure the Lua language server. For pre-made configurations, check out
-- https://github.com/neovim/nvim-lspconfig
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".git" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT"
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					"${3rd}/luv/library",
				},
			},
		},
	},
})

-- Enable language servers. If you are using lspconfig (mentioned above), you
-- can find all of the available servers by running `:help lspconfig-all`.
vim.lsp.enable({ "lua_ls" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LilLspAttach", { clear = false }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf)
		end

		if client:supports_method("textDocument/foldingRange") then
			local win_id = vim.api.nvim_get_current_win()
			vim.wo[win_id].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end

		if client:supports_method("textDocument/codeAction") then
			vim.api.nvim_buf_create_user_command(args.buf, "OrganiseImports", function()
				vim.lsp.buf.code_action({
					context = {
						only = { "source.organizeImports" },
					},
				})
			end, { desc = "Organise imports" })
		end
	end
})
