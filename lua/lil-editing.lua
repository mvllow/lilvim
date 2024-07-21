---
--- lil-editing.lua
--- https://github.com/mvllow/lilvim
---
--- Setup general editing options and keymaps.
---
---@keymaps
--- |NORMAL|
--- gcc : comment line
--- |VISUAL|
--- gc  : comment selection

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Continue wrapped lines with matching indentation
vim.opt.breakindent = true
vim.opt.linebreak = true
-- Visually show indented lines, e.g. if this line were to naturally wrap
-- \\you would see "\\" as demonstrated at the start of this line
vim.opt.showbreak = [[\\]]

-- Persistent undo between sessions
vim.opt.undofile = true

-- Start scrolling before reaching the edge of the screen
vim.opt.scrolloff = 3

-- Copy and paste via clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- Navigate through wrapped lines via j/<down>, k/<up>
vim.keymap.set({ "n", "v" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set({ "n", "v" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set({ "n", "v" }, "<up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set({ "n", "v" }, "<down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })

-- Navigate quickfix list
vim.keymap.set("n", "]q", ":cnext<cr>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", ":cprev<cr>zz", { desc = "Previous quickfix" })
