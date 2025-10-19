---@tag lil-search
---@signature require"lil-search"
---@text File management and search
---
--- Features:
---
--- - Enable case-insensitive search for lowercase queries
---
--- # Commands ~
---
--- - :Explore : Explore files
--- - :find    : Find files
--- - :grep    : Find in files (results are sent to quickfix)
---
--- # Keymaps ~
---
--- - Normal
---   - <leader>e : Explore files
---   - <leader>f : Find files
---   - <leader>/ : Find in files (results are sent to quickfix)
--- - Netrw
---   - <cr>      : Open file
---   - %         : Create a new file
---   - d         : Create a new directory
---   - D         : Delete a file or empty directory
---   - mf        : Mark file or directory
---   - mt        : Set target directory for marked actions
---   - mm        : Move marked files to the marked target
---
--- # Options ~
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
vim.o.ignorecase = true -- ignore case
vim.o.smartcase  = true -- unless search contains uppercase
--minidoc_afterlines_end
---
--- Optionally, if you have FZF installed you may enable the vim plugin: >lua
--- 	local fzf_path = string.gsub(vim.fn.exepath("fzf"), "bin", "opt")
--- 	vim.opt.runtimepath:append(fzf_path)
--- 	vim.keymap.set("n", "<leader>f", ":FZF<cr>", { desc = "Find files" })
---
---@seealso lil-quickfix

vim.keymap.set("n", "<leader>e", ":Explore<cr>", { desc = "Explore files" })
vim.keymap.set("n", "<leader>f", ":find ", { desc = "Find files" })
vim.keymap.set("n", "<leader>/", ":grep ", { desc = "Find in files" })

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
