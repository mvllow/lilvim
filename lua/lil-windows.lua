---@tag lil-windows
---@signature require"lil-windows"
---@text Window management

vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("LilWindowsResize", { clear = true }),
	command = "tabdo wincmd =",
	desc = "Maintain window ratios after resize",
})
