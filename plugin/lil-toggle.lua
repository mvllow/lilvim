---@tag lil-toggle
---@signature
---@text Toggle options, augroups and more
---
--- # Commands ~
---
--- - :LilToggle <option> : Toggle thing
---
--- # Keymaps ~
---
--- No keymaps are set automatically. See the examples below.
---
--- Example keymaps: >lua
--- 	local function map_toggle(key, option)
--- 		local prefix = ','
--- 		vim.keymap.set(
--- 			'n',
--- 			prefix .. key,
--- 			':LilToggle ' .. option .. '<cr>',
--- 			{ desc = 'toggle ' .. option }
--- 		)
--- 	end
--- 	map_toggle('a', 'autocomplete')
--- 	map_toggle('b', 'background')
--- 	map_toggle('c', 'cmdheight')
--- 	map_toggle('d', 'diagnostic')
--- 	map_toggle('D', 'document_color')
--- 	map_toggle('f', 'FormatOnSave')
--- 	map_toggle('i', 'inlay_hint')
--- 	map_toggle('l', 'list')
--- 	map_toggle('m', 'laststatus')
--- 	map_toggle('M', 'winbar')
--- 	map_toggle('n', 'number')
--- 	map_toggle('q', 'quickfix')
--- 	map_toggle('s', 'spell')
--- 	map_toggle('w', 'wrap')

local state = {}

local function notify(value, log_level)
	vim.notify("[lil-toggle] " .. value, log_level or vim.log.levels.INFO, { title = "lil-toggle" })
end

local function notify_set(opt, value)
	notify("set " .. opt .. " to " .. tostring(value))
end

local function try_toggleable(obj, opt)
	if obj and type(obj.enable) == "function" and type(obj.is_enabled) == "function" then
		obj.enable(not obj.is_enabled())
		notify_set(opt, obj.is_enabled())
		return true
	end
end

local function toggle_quickfix()
	local is_open = vim.tbl_contains(vim.tbl_map(function(w) return w.quickfix == 1 end, vim.fn.getwininfo()), true)
	if is_open then
		vim.cmd("cclose")
		notify("quickfix closed")
		return
	end

	if vim.tbl_isempty(vim.fn.getqflist()) then
		notify("quickfix is empty")
		return
	end

	vim.cmd("copen")
	notify("quickfix opened")
end

local function toggle(opt)
	if opt == "quickfix" then
		toggle_quickfix()
		return
	end

	local ok, val = pcall(function() return vim.o[opt] end)
	if not ok then
		goto try_toggleable
	end

	if type(val) == "boolean" then
		vim.o[opt] = not val
		notify_set(opt, vim.o[opt])
		return
	end

	if type(val) == "number" then
		if val == 0 then
			vim.o[opt] = state[opt] or 1
		else
			state[opt] = val
			vim.o[opt] = 0
		end
		notify_set(opt, vim.o[opt])
		return
	end

	if type(val) == "string" then
		if val == "light" or val == "dark" then
			vim.o[opt] = val == "light" and "dark" or "light"
			notify_set(opt, vim.o[opt])
			return
		end

		if val == "" then
			vim.o[opt] = state[opt] or ""
		else
			state[opt] = val
			vim.o[opt] = ""
		end
	end

	::try_toggleable::

	if try_toggleable(vim[opt], opt) or try_toggleable(vim.lsp[opt], opt) then
		return
	end

	local has_cmds, cmds = pcall(vim.api.nvim_get_autocmds, { group = opt })
	if has_cmds and type(cmds) == "table" then
		state[opt] = cmds
		pcall(vim.api.nvim_del_augroup_by_name, opt)
		notify(opt .. " disabled")
		return
	end

	vim.api.nvim_create_augroup(opt, { clear = true })
	cmds = state[opt]
	if type(cmds) == "table" then
		for _, cmd in pairs(cmds) do
			local opts = { desc = cmd.desc or "", group = cmd.group_name or opt }
			if cmd.pattern then
				opts.pattern = cmd.pattern
			elseif cmd.buffer then
				opts.buffer = cmd.buffer
			end
			if cmd.callback then
				opts.callback = cmd.callback
			elseif cmd.command then
				opts.command = cmd.command
			end
			vim.api.nvim_create_autocmd(cmd.event, opts)
		end
		notify(opt .. "enabled")
	end
end

vim.api.nvim_create_user_command("LilToggle", function(opts)
	toggle(opts.args)
end, { nargs = "+", desc = "Toggle things" })
