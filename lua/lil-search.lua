---
--- lil-search.lua
--- https://github.com/mvllow/lilvim
---
--- Setup file management and search.
---
---@commands
--- |netrw|
--- :Explore
---   Open file explorer
--- |grep|
--- :grep <string>
---   Fuzzy search file contents, sending the results to the quickfix list
--- |quickfix|
--- :copen
---   Open the quickfix list
--- :cnext or ]q
---   Goto next quickfix item
--- :cprev or [q
---   Goto previous quickfix item
--- |FZF|
--- :FZF <directory?>
---   Fuzzy search files
---
---@keymaps
--- |netrw|
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
	-- Use `:grep <string>` to search
	vim.o.grepprg = "rg --vimgrep --smart-case"
end

if vim.fn.executable("fzf") ~= 0 then
	-- NOTE: This path can be found via `which fzf` in your terminal
	vim.opt.runtimepath:append("/opt/homebrew/opt/fzf")
	vim.keymap.set("n", "<leader>f", ":FZF<cr>")
end
