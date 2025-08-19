---@tag lil-edit
---@signature require"lil-edit"
---@text General editing keymaps and options
---
--- # Keymaps ~
---
--- - Normal
---   - <leader>y : Copy to clipboard
---   - <leader>p : Paste from clipboard
---   - j/k       : Navigate wrapped lines
---   - gcc       : Comment line
--- - Visual
---   - gc        : Comment selection
---
--- # Options ~
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
vim.o.tabstop     = 4      -- tab size
vim.o.shiftwidth  = 4      -- auto-indent tab size
vim.o.breakindent = true   -- visually indent wrapped lines
vim.o.linebreak   = true   -- avoid wrapping mid-word
vim.o.showbreak   = [[\\]] -- show "\\" at the beginning of wrapped lines
vim.o.undofile    = true   -- persistent undo between sessions
vim.o.scrolloff   = 3      -- scroll before reaching the edge of buffer
--minidoc_afterlines_end

-- Copy and paste via clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- Navigate through wrapped lines
vim.keymap.set({ "n", "v" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set({ "n", "v" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set({ "n", "v" }, "<up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set({ "n", "v" }, "<down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
