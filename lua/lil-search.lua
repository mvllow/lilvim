---@tag lil-search
---@signature require"lil-search"
---@text File management and search
---
--- Features:
---
--- - Enable case-insensitive search for lowercase queries
--- - Enable FZF if available
---
--- # Commands ~
---
--- - :Explore : Open file explorer
--- - :FZF     : Fuzzy search files
--- - :grep    : Fuzzy search file contents
---
--- # Keymaps ~
---
--- - Normal
---   - <leader>e : Open file explorer
---   - <leader>f : Fuzzy find files
--- - Netrw
---   - <cr>      : Open file
---   - %         : Create a new file
---   - d         : Create a new directory
---   - D         : Delete a file or empty directory
--- - FZF
---   - <cr>      : Open file
---   - <tab>     : Mark file
---
--- # Options ~
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
vim.o.ignorecase = true -- ignore case
vim.o.smartcase  = true -- unless search contains uppercase
--minidoc_afterlines_end
---
---@seealso lil-grep lil-quickfix

vim.keymap.set("n", "<leader>e", ":Ex<cr>", { desc = "Open file explorer" })

if vim.fn.executable("fzf") == 1 then
	local fzf_bin_path = vim.fn.exepath("fzf")
	if fzf_bin_path ~= "" then
		local fzf_plugin_path = string.gsub(fzf_bin_path, "bin", "opt")
		vim.opt.runtimepath:append(fzf_plugin_path)
		vim.keymap.set("n", "<leader>f", ":FZF<cr>", { desc = "Fuzzy find" })
	end
end
