---@tag lil-lsp
---@signature require"lil-lsp"
---@text Language servers and diagnostics
---
--- Features:
---
---   - Configure diagnostics
---   - Configure language servers
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

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LilLspAttach", { clear = false }),
	callback = function(event)
		vim.lsp.completion.enable(true, event.data.client_id, event.buf, { autotrigger = false })
	end,
})
