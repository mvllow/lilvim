---
--- lil-formatting.lua
--- https://github.com/mvllow/lilvim
---
--- Setup formatters with format on save.
---
--- Formatters must be available in your runtimepath.
---@see |runtimepath|
---
---@commands
--- :ConformInfo
---   Show current formatter status
---
---@keymaps
--- |VISUAL|
--- gq : format selection
---


local prettier_cmd = { "prettierd", "prettier", stop_after_first = true }

MiniDeps.add("stevearc/conform.nvim")
require("conform").setup({
	notify_on_error = false,
	default_format_opts = { lsp_format = "fallback" },
	formatters_by_ft = {
		fish = { "fish_indent" },
		go = { "goimports" },
		lua = { "stylua" },
		rust = { "rustfmt" },

		-- prettier (default)
		javascript = prettier_cmd,
		javascriptreact = prettier_cmd,
		typescript = prettier_cmd,
		typescriptreact = prettier_cmd,
		vue = prettier_cmd,
		css = prettier_cmd,
		scss = prettier_cmd,
		less = prettier_cmd,
		html = prettier_cmd,
		json = prettier_cmd,
		jsonc = prettier_cmd,
		graphql = prettier_cmd,
		markdown = prettier_cmd,
		yaml = prettier_cmd,

		-- prettier (via extensions)
		astro = prettier_cmd,
		svelte = prettier_cmd,
	},
})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
	pattern = "*",
	callback = function()
		require("conform").format()
	end,
})
