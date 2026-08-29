---@tag lil-search
---@signature
---@text Features:
---
--- - Enable case-insensitive search for lowercase queries
---
--- Commands ~
---
--- - `:Explore`         : Explore files
---
--- - `:find PATTERN`   : Find files
--- - `:grep PATTERN`   : Find text (results in quickfix)
---
--- - `:s//REPLACEMENT` : replace PATTERN (search)
---
--- Keymaps ~
---
--- - `<Leader>f`  : Find files
--- - `<Leader>/`  : Find in files (results in quickfix)
---
--- - `*`         : Search cursorword
--- - `#`         : Backward search cursorword
---
--- - `gf`        : Goto pattern under cursor
--- - `gx`        : Open pattern under cursor
---
--- - `<C-^>`     : Goto alternate file
--- - `<C-i>`     : Next jump list position
--- - `<C-o>`     : Previous jump list position
---
--- - `<Leader>e` : Open file explorer
--- - `<CR>`      : Open file
--- - `%`         : Create a new file
--- - `d`         : Create a new directory
--- - `D`         : Delete a file or empty directory
--- - `mf`        : Mark file or directory
--- - `mt`        : Set target directory for marked actions
--- - `mm`        : Move marked files to the set target
---
--- Options ~
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
vim.o.ignorecase = true -- ignore case
vim.o.smartcase  = true -- unless search contains uppercase
--minidoc_afterlines_end
---
---@seealso |lil-quickfix|

vim.keymap.set("n", "<leader>e", ":Explore<cr>", { desc = "Explore files" })
vim.keymap.set("n", "<leader>f", ":find ", { desc = "Find files" })
vim.keymap.set("n", "<leader>/", ":silent grep ", { desc = "Find in files" })

if vim.fn.executable("fd") == 1 then
	function _G.FindFiles(arg)
		local fnames = vim.fn.systemlist("fd --hidden --exclude=.git --color=never")
		if #arg == 0 then
			return fnames
		end
		return vim.fn.matchfuzzy(fnames, arg)
	end

	vim.o.findfunc = "v:lua.FindFiles"
end

if vim.fn.executable("rg") == 1 then
	vim.o.grepprg = "rg --vimgrep --hidden --smart-case"
end
