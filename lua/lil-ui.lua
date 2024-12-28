---
--- lil-ui.lua
--- https://github.com/mvllow/lilvim
---
--- Setup interface.
---

vim.o.guicursor = ""
vim.o.signcolumn = "yes"

vim.api.nvim_create_autocmd("VimResized", {
	command = "tabdo wincmd =",
	desc = "Balance windows",
})
