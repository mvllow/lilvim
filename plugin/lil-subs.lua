---@tag lil-subs
---@signature
---@text Substitute your text, with different text!
---
--- Features:
---
--- - Automatic text replacements when spell checking is enabled
--- - Shows virtual text previews for HTML entities
--- - Expands unicode shortcuts prefixed with "_" (e.g. _middot becomes •)
--- - Displays ASCII equivalents for special characters (e.g. em dash shows --)
---
--- # Commands ~
---
--- - :ab : List abbreviations
---
--- # Highlights ~
---
--- - LilSubsHint : Virtual text color (default links to Comment)
---
--- # Options ~
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
vim.o.spell = true
--minidoc_afterlines_end

vim.api.nvim_set_hl(0, "LilSubsHint", { link = "Comment", default = true })

--- Unicode symbols. Type `_name` to insert or `&name;` to preview.
---
---@type table<string, string>
---@private
local entity_map = {
	["aleph"] = "ℵ",
	["alpha"] = "α",
	["amp"] = "&",
	["and"] = "∧",
	["angle"] = "∠",
	["apos"] = "'",
	["approx"] = "≈",
	["ballotx"] = "✘",
	["beta"] = "β",
	["bull"] = "•",
	["cap"] = "∩",
	["check"] = "✓",
	["clubs"] = "♣",
	["copy"] = "©",
	["cross"] = "✗",
	["cup"] = "∪",
	["dagger"] = "†",
	["Dagger"] = "‡",
	["darr"] = "↓",
	["deg"] = "°",
	["diams"] = "♦",
	["divide"] = "÷",
	["ell"] = "ℓ",
	["empty"] = "∅",
	["equiv"] = "≡",
	["euro"] = "€",
	["exist"] = "∃",
	["forall"] = "∀",
	["frakR"] = "ℛ",
	["geq"] = "≥",
	["gt"] = ">",
	["harr"] = "↔",
	["hearts"] = "♥",
	["hellip"] = "…",
	["imag"] = "ℑ",
	["infty"] = "∞",
	["int"] = "∫",
	["isin"] = "∈",
	["lambda"] = "λ",
	["laquo"] = "«",
	["larr"] = "←",
	["leq"] = "≤",
	["loz"] = "◊",
	["lt"] = "<",
	["mdash"] = "—",
	["micro"] = "µ",
	["middot"] = "·",
	["nabla"] = "∇",
	["ndash"] = "–",
	["nearr"] = "↗",
	["neq"] = "≠",
	["ni"] = "∋",
	["not"] = "¬",
	["notin"] = "∉",
	["omega"] = "ω",
	["or"] = "∨",
	["para"] = "¶",
	["part"] = "∂",
	["permil"] = "‰",
	["pi"] = "π",
	["prime"] = "′",
	["Prime"] = "″",
	["prod"] = "∏",
	["prop"] = "∝",
	["quot"] = "\"",
	["raquo"] = "»",
	["rarr"] = "→",
	["real"] = "ℜ",
	["reg"] = "®",
	["sect"] = "§",
	["sigma"] = "σ",
	["spades"] = "♠",
	["spcheck"] = "✔",
	["sum"] = "∑",
	["there4"] = "∴",
	["times"] = "×",
	["trade"] = "™",
	["uarr"] = "↑",
	["weierp"] = "℘",
	["yen"] = "¥",
}

--- Special characters with ASCII hints shown as virtual text.
---
---@type table<string, string>
---@private
local display_map = {
	["—"] = "--", -- em dash
	["–"] = "-", -- en dash
}

--- Text shortcuts. Type the key to expand to the value.
---
---@type table<string, string>
---@private
local replace_map = {
	["omw"] = "On my way!",
}

local keymap_ids = {}

local function update_keymaps()
	for before, _ in pairs(keymap_ids) do
		pcall(vim.keymap.del, "ia", before)
	end
	keymap_ids = {}

	if vim.o.spell then
		for name, symbol in pairs(entity_map) do
			local abbrev = "_" .. name
			vim.keymap.set("ia", abbrev, function() return symbol end, { expr = true })
			keymap_ids[abbrev] = true
		end

		for abbrev, replacement in pairs(replace_map) do
			vim.keymap.set("ia", abbrev, function() return replacement end, { expr = true })
			keymap_ids[abbrev] = true
		end
	end
end

local function show_virtual_text()
	local bufnr = vim.api.nvim_get_current_buf()
	local ns_id = vim.api.nvim_create_namespace("lil_subs")

	vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

	if not vim.o.spell then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	for line_nr, line in ipairs(lines) do
		local start_pos = 1

		-- Handle HTML entities
		while true do
			local entity_start = line:find("&", start_pos, true)
			if not entity_start then
				break
			end

			local entity_end = line:find(";", entity_start, true)
			if not entity_end then
				break
			end

			local entity_name = line:sub(entity_start + 1, entity_end - 1)
			local symbol = entity_map[entity_name]

			if symbol then
				vim.api.nvim_buf_set_extmark(bufnr, ns_id, line_nr - 1, entity_end, {
					virt_text = { { "(" .. symbol .. ")", "LilSubsHint" } },
					virt_text_pos = "inline",
				})
			end

			start_pos = entity_end + 1
		end

		-- Handle display hints
		for char, display in pairs(display_map) do
			start_pos = 1
			while true do
				local char_pos = line:find(char, start_pos, true)
				if not char_pos then
					break
				end

				vim.api.nvim_buf_set_extmark(bufnr, ns_id, line_nr - 1, char_pos + #char - 1, {
					virt_text = { { "(" .. display .. ")", "LilSubsHint" } },
					virt_text_pos = "inline",
				})

				start_pos = char_pos + #char
			end
		end
	end
end

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
	group = vim.api.nvim_create_augroup("LilSubsVirtualText", { clear = true }),
	pattern = "*",
	callback = show_virtual_text,
})

vim.api.nvim_create_autocmd("OptionSet", {
	group = vim.api.nvim_create_augroup("LilSubsKeymaps", { clear = true }),
	pattern = { "spell" },
	callback = function()
		update_keymaps()
		show_virtual_text()
	end,
})

update_keymaps()
