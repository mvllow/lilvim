---
--- lil-lsp.lua
--- https://github.com/mvllow/lilvim
---
--- Setup diagnostics and language servers.
---
--- Servers must be available in your |runtimepath|.
---
---@commands
--- :LspInfo
---   Show current LSP status
--- :Lsp<tab>
---   Autocomplete all available commands
---
---@keymaps :help lsp-defaults
--- |NORMAL|
--- K          : show symbol documentation
--- gra        : list code actions
--- gri        : list implementations
--- grn        : rename symbol
--- grr        : list references
--- <c-]>      : goto definition
--- <c-w>d     : show line diagnostics
--- |VISUAL|
--- gq         : format selection
--- |INSERT|
--- <c-s>      : signature help
--- <c-x><c-o> : show completions in pmenu (popup menu)
--- |PMENU|
--- <c-n>      : focus next result
--- <c-p>      : focus previous result
--- <c-y>      : select result

MiniDeps.add("neovim/nvim-lspconfig")

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("CustomLspAttach", { clear = false }),
	callback = function(event)
		vim.lsp.completion.enable(true, event.data.client_id, event.buf, { autotrigger = false })
	end,
})
