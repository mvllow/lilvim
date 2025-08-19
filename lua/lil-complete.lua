---@tag lil-complete
---@signature require"lil-complete"
---@text Text (auto)completion
---
--- # Keymaps ~
---
--- - Normal
---   - <c-n> : Focus next result
---   - <c-p> : Focus previous result
---   - <c-y> : Select result
---
--- # Options ~
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
vim.o.complete     = ".,o"                    -- complete from buffer and omnifunc
vim.o.completeopt  = "fuzzy,menuone,noselect" -- complete popup behaviour
vim.o.autocomplete = true                     -- suggest while typing
--minidoc_afterlines_end
---
---@seealso lil-lsp
