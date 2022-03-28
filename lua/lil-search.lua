--- lil-search.lua
--- https://github.com/mvllow/lilvim

--- Setup search.

vim.opt.ignorecase = true
vim.opt.smartcase = true

local opts = { silent = true }
vim.keymap.set('n', '<esc>', ':noh<cr>', opts) -- clear search highlights
vim.keymap.set('n', '*', '*N', opts) -- search word under cursor (keep position)
vim.keymap.set('v', '*', [[y/\V<c-r>=escape(@",'/\')<cr><cr>N]], opts) -- search selection (keep position)
