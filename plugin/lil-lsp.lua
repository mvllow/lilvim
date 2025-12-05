---@tag lil-lsp
---@signature
---@text Language servers and diagnostics
---
--- Features:
---
--- - Configure diagnostics
--- - Configure language servers
---
--- NOTE: Server executables must be available in your |runtimepath|.
---
--- # Commands ~
---
--- - :checkhealth lsp : Show current LSP status
---
--- # Keymaps ~
---
--- - Normal
---   - K          : Show symbol documentation
---   - gq         : Format file
---   - gO         : List document symbols
---   - gra        : List code actions
---   - gri        : List implementations
---   - grr        : List references
---   - grn        : Rename symbol
---   - gro        : Organise imports
---   - <c-]>      : Goto definition
---   - ]d         : Goto next diagnostic
---   - ]D         : Goto last diagnostic
---   - [d         : Goto previous diagnostic
---   - [D         : Goto first diagnostic
---   - <c-w>d     : Show line diagnostics
--- - Visual
---   - gq         : Format selection
--- - Insert
---   - <c-s>      : Signature help
---   - <c-x><c-o> : Show completions in pmenu (popup menu)
--- - Pmenu
---   - <c-n>      : Focus next result
---   - <c-p>      : Focus previous result
---   - <c-y>      : Select result
---
--- # Options ~
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
vim.o.signcolumn = "yes" -- always show sign column (reduce layout shift)
--minidoc_afterlines_end
---
---@seealso lsp-defaults

vim.keymap.set("n", "gq", function() vim.lsp.buf.format() end, { desc = "Format file" })

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT"
			},
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
			},
		},
	},
})
vim.lsp.enable("lua_ls")

vim.api.nvim_create_user_command("LspCapabilities", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	for _, client in ipairs(clients) do
		vim.print("Client: " .. client.name)
		vim.print("Server capabilities:")
		vim.print(client.server_capabilities)
	end
end, { desc = "Show LSP server capabilities" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LilLspAttach", { clear = false }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = false })

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf)
		end

		-- "background" style is enabled by default on nightly
		if client:supports_method("textDocument/documentColor") or vim.lsp.document_color then
			vim.lsp.document_color.enable(true, args.buf, { style = "virtual" })
		end

		if client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end

		if client:supports_method("textDocument/codeAction") then
			vim.api.nvim_buf_create_user_command(args.buf, "OrganiseImports", function()
				vim.lsp.buf.code_action({
					context = {
						only = { "source.organizeImports" },
						diagnostics = {}
					},
					apply = true
				})
			end, { desc = "Organise imports" })

			vim.keymap.set("n", "gro", ":OrganiseImports<cr>", {
				buffer = args.buf,
				desc = "Organise imports"
			})
		end
	end
})
