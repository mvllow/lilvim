---
--- lil-search.lua
--- https://github.com/mvllow/lilvim
---
--- Setup file management and search.
---
---@commands
--- :Explore
---   Open file explorer (:help explore)
--- :grep <string>
---   Fuzzy search file contents, sending the results to the quickfix list
--- :copen
---   Open the quickfix list (:help quickfix)
--- :cnext
---   Goto next quickfix item
--- :cprev
---   Goto previous quickfix item
--- :FZF <directory?>
---   Fuzzy search files
---
---@keymaps
--- |EXPLORE|
--- <cr>  : Open file
--- %     : Create a new file
--- d     : Create a new directory
--- D     : Delete a file or empty directory
--- |FZF|
--- <cr>  : Open file
---	<tab> : Mark file
---

-- Case-insensitive search, unless search contains uppercase
vim.o.ignorecase = true
vim.o.smartcase = true

vim.keymap.set("n", "<leader>e", ":Ex<cr>")

if vim.fn.executable("rg") ~= 0 then
	-- Use `:grep some-text` to search
	vim.o.grepprg = "rg --vimgrep"
end

if vim.fn.executable("fzf") ~= 0 then
	vim.opt.runtimepath:append("/opt/homebrew/opt/fzf")
	vim.keymap.set("n", "<leader>f", ":FZF<cr>")
end
