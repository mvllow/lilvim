local minidoc = require("mini.doc")

if _G.MiniDoc == nil then
	minidoc.setup()
end

local hooks = vim.deepcopy(minidoc.default_hooks)

hooks.write_pre = function(lines)
	-- Remove first two lines with `======` and `------` delimiters to comply
	-- with `:h local-additions` template
	table.remove(lines, 1)
	table.remove(lines, 1)
	return lines
end

local files = { "script/doc-header.lua" }
local plugin_files = vim.fn.glob("lua/*.lua", false, true)
table.sort(plugin_files)

for _, file in ipairs(plugin_files) do
	table.insert(files, file)
end

minidoc.generate(files, "doc/lilvim.txt", { hooks = hooks })
