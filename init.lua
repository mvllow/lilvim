--- init.lua
--- https://github.com/mvllow/lilvim
---
--- Combines all modules of lilvim.

-- Set leader key before loading modules for accurate mappings
vim.g.mapleader = " "

-- Modules
require("lil-editing")
require("lil-grep")
require("lil-lsp")
require("lil-search")
require("lil-places")
require("lil-quickfix")
