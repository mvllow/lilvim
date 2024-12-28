---
--- lil-lsp.lua
--- https://github.com/mvllow/lilvim
---
--- Setup diagnostics and language servers.
---
--- Servers must be available in your |runtimepath|.
---
---@commands
--- |lspconfig|
--- :Lsp<tab>
---   Autocomplete all available commands
--- :checkhealth lsp
---   Show current LSP status
---
---@keymaps :help lsp-defaults
--- |NORMAL|
--- K          : show symbol documentation
--- gq         : format file
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
vim.keymap.set("n", "gq", function()
	vim.lsp.buf.format()
	-- Workaround for diagnostics disappearing when formatting with no changes
	-- https://github.com/neovim/neovim/issues/25014
	vim.diagnostic.enable()
end, { desc = "Format file" })

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
