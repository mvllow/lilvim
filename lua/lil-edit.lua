---@tag lil-edit
---@signature
---@text Features:
---
--- - Improve wrapped line behaviour
--- - Copy and paste via the system clipboard
--- - Persistent undo between sessions
---
--- Keymaps ~
---
--- - `j/k`        : Navigate wrapped lines
---
--- - `gcc`        : Comment line
--- - `gc`         : Comment visual selection
---
--- - `<C-x><C-o>` : Show completion options in *insert mode*
--- - `<C-n>`      : Focus next item
--- - `<C-p>`      : Focus previous item
--- - `<C-y>`      : Select item
---
--- Options ~
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
vim.o.autocomplete = false
if vim.o.autocomplete then
	vim.o.completeopt = "menuone,fuzzy,preview,noselect"
else
	vim.o.completeopt = "menuone,fuzzy,popup,noselect"
end

vim.o.tabstop = 4                -- tab size
vim.o.shiftwidth = 4             -- auto-indent tab size

vim.o.breakindent = true         -- visually indent wrapped lines
vim.o.breakindentopt = "list:-1" -- visually align wrapped list items
vim.o.linebreak = true           -- avoid wrapping mid-word
vim.o.showbreak = [[\\]]         -- show "\\" at the start of wrapped lines

vim.o.scrolloff = 3              -- scroll before reaching the buffer edge

vim.o.undofile = true            -- persistent undo between sessions
--minidoc_afterlines_end

-- Copy and paste via clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<Leader>p", '"+p', { desc = "Paste from clipboard" })

-- Navigate through wrapped lines
vim.keymap.set({ "n", "v" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set({ "n", "v" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set({ "n", "v" }, "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set({ "n", "v" }, "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })

-- Configure behaviour per filetype
-- Tip: use `:echo &filetype` to get the current buffer's filetype
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"gitcommit",
		"markdown",
	},
	callback = function()
		vim.wo.spell = true
	end
})
