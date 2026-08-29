---@tag lil-lsp
---@signature
---@text Features:
---
--- - Configure language servers
--- - Configure diagnostics
---
--- NOTE: Server executables must be available in your |runtimepath|.
---
--- Variables ~
---
--- - `b:lil_lsp_clients` : String of running LSP servers
---
--- Show LSP clients in the winbar: >lua
--- 	vim.cmd([[set winbar+=%{get(b:,'lil_lsp_clients','')}]])
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

local function update_lsp_clients(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	if #clients == 0 then
		vim.b[bufnr].lil_lsp_clients = ""
		return
	end

	local client_names = {}
	for _, client in ipairs(clients) do
		table.insert(client_names, client.name)
	end

	vim.b[bufnr].lil_lsp_clients = "∷ " .. table.concat(client_names, ", ")
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LilLspAttach", { clear = false }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		update_lsp_clients(args.buf)

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
						diagnostics = {}
					},
					apply = true
				})
			end, { desc = "Organise imports" })
		end
	end
})

vim.api.nvim_create_autocmd("LspDetach", {
	group = vim.api.nvim_create_augroup("LilLspDetach", { clear = true }),
	callback = function(args)
		update_lsp_clients(args.buf)
	end
})
