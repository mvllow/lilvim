---
--- lil-lsp.lua
--- https://github.com/mvllow/lilvim
---
--- Setup diagnostics and language servers.
---
--- Servers must be available in your |runtimepath|.
---
---@commands
--- :checkhealth lsp : Show current LSP status
---
---@keymaps :help lsp-defaults
--- |NORMAL|
--- K          : Show symbol documentation
--- gq         : Format file
--- gO         : List document symbols
--- gra        : List code actions
--- gri        : List implementations
--- grr        : List references
--- grn        : Rename symbol
--- <c-]>      : Goto definition
--- ]d         : Goto next diagnostic
--- ]D         : Goto last diagnostic
--- [d         : Goto previous diagnostic
--- [D         : Goto first diagnostic
--- <c-w>d     : Show line diagnostics
--- |VISUAL|
--- gq         : Format selection
--- |INSERT|
--- <c-s>      : Signature help
--- <c-x><c-o> : Show completions in pmenu (popup menu)
--- |PMENU|
--- <c-n>      : Focus next result
--- <c-p>      : Focus previous result
--- <c-y>      : Select result

-- Always show sign column, preventing a flicker when going from 0 diagnostics to > 0
vim.o.signcolumn = "yes"

vim.keymap.set("n", "gq", function()
	vim.lsp.buf.format()
	-- Workaround for diagnostics disappearing when formatting with no changes
	-- https://github.com/neovim/neovim/issues/25014
	vim.diagnostic.enable()
end, { desc = "Format file" })

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".editorconfig", ".git", ".luarc.json", ".luarc.jsonc", vim.uv.cwd() },
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
