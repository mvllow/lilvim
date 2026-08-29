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
--- - `{count}-` : Open directory listing
--- - `<CR>`     : Open file
--- - `R`        : Reload directory listing
---
--- Options ~
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
vim.o.ignorecase = true -- ignore case
vim.o.smartcase  = true -- unless search contains uppercase
--minidoc_afterlines_end
---
---@seealso |lil-quickfix|

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
