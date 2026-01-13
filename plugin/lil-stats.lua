---@tag lil-stats
---@signature
---@text Show file statistics
---
--- # Variables ~
---
---   - b:lil_stats_file
---
--- Show stats in the winbar: >lua
--- 	vim.cmd([[set winbar+=%{get(b:,'lil_stats_file','')}]])

--- Count lines of code for the current buffer
---@param include_comments boolean? Include comment lines in count
---@private
local function count_loc(include_comments)
	include_comments = include_comments or false

	local count = 0
	local commentpattern = ""

	if not include_comments then
		local commentstring = vim.bo.commentstring or ""
		-- Remove variable placeholder, e.g. "-- %s" → "--"
		commentpattern = commentstring:gsub("%%s.*", ""):gsub("%s+", "")
		-- Escape special lua pattern characters, e.g. "--" → "%-%-"
		commentpattern = commentpattern:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
	end

	for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
		local trimmed = line:match("^%s*(.*)$")
		local is_non_empty = trimmed:match("%S")
		local is_comment = not include_comments and trimmed:match("^" .. commentpattern)
		if is_non_empty and (include_comments or not is_comment) then
			count = count + 1
		end
	end
	return count
end

--- Format human-readable file size
---@private
local function format_size()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		return "0 Bytes"
	end

	local size = vim.fn.getfsize(file)
	if size < 0 then
		return "0 Bytes"
	end
	if size < 1024 then
		return size .. " Bytes"
	end
	if size < 1024 * 1024 then
		return string.format("%.1f KB", size / 1024)
	end
	return string.format("%.1f MB", size / (1024 * 1024))
end

local function get_file_stats()
	local lines = vim.api.nvim_buf_line_count(0)
	local loc = count_loc()
	local size = format_size()
	vim.b.lil_stats_file = string.format("%d lines (%d loc) · %s", lines, loc, size)
end

vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("LilStatsFile", { clear = true }),
	callback = get_file_stats,
})

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	group = vim.api.nvim_create_augroup("LilStatsFileDebounced", { clear = true }),
	callback = function()
		vim.defer_fn(get_file_stats, 500)
	end,
})
