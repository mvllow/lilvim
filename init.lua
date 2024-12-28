--- init.lua
--- https://github.com/mvllow/lilvim
---
--- Combines all modules of lilvim.

-- Set leader key before loading modules for accurate mappings
vim.g.mapleader = " "

-- Bootstrap package manager
-- We use mini.deps to have a globally available way to manage packages
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.deps"
if not vim.uv.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.deps`" | redraw')
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/echasnovski/mini.deps",
		mini_path,
	})
	vim.cmd("packadd mini.deps | helptags ALL")
	vim.cmd('echo "Installed `mini.deps`" | redraw')
end
require("mini.deps").setup({ path = { package = path_package } })

-- Modules
require("lil-editing")
require("lil-formatting")
require("lil-lsp")
require("lil-search")
require("lil-ui")
