---@tag lil-grep
---@signature require"lil-grep"
---@text Extend built-in grep behaviour
---
--- Features:
---
--- - Silences output
--- - Automatically manages the quickfix window
---
--- Based on the vimscript implementation:
--- https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
---
--- # Commands ~
---
--- - :Grep <query> : Search files
---
---@seealso lil-quickfix

if vim.fn.executable("rg") == 1 then
	-- Add `--smart-case` and remove `-uu` from the default grepprg
	vim.o.grepprg = "rg --vimgrep --smart-case"
end

local function grep(...)
	local cmd = { vim.o.grepprg }
	local args = vim.fn.join({ ... }, " ")

	-- Convert 'pattern' to "pattern", escaping any inner double quotes
	args = args:gsub("^'(.*)'$", function(inner)
		inner = inner:gsub('"', '\\"')
		return '"' .. inner .. '"'
	end)

	table.insert(cmd, vim.fn.expandcmd(args))
	return vim.fn.system(vim.fn.join(cmd, " "))
end

vim.api.nvim_create_user_command("Grep", function(opts)
	vim.fn.setqflist({}, " ", {
		title = "lil-grep",
		lines = vim.fn.split(grep(opts.args), "\n")
	})
	vim.cmd("cwindow")
end, {
	nargs = "+",
	complete = "file_in_path",
	desc = "Search file contents"
})

-- Transform `:grep` into the user command `:Grep`
vim.keymap.set("ca", "grep", function()
	if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "grep" then
		return "Grep"
	end
	return "grep"
end, { expr = true, replace_keycodes = false })
