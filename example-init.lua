--- *lilvim* A modular and opinionated starting point for Neovim
--- *Lilvim*
---
--- MIT License Copyright (c) mvllow
---
--- ==============================================================================
---
--- Features:
---
--- - Self-contained modules
--- - Prioritised built-in functionality
--- - Deliciously simple to extend
---
--- Modules:
---
--- - |lil-complete|
--- - |lil-edit|
--- - |lil-grep|
--- - |lil-lsp|
--- - |lil-places|
--- - |lil-quickfix|
--- - |lil-search|
--- - |lil-stats|
--- - |lil-subs|
--- - |lil-windows|
---
--- # Setup ~
---
--- Lilvim modules can be directly copied into your own config or consumed
--- similar to other plugins. Either path allows requiring individual modules:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
require("lil-complete")
require("lil-edit")
require("lil-grep")
require("lil-lsp")
require("lil-places")
require("lil-quickfix")
require("lil-search")
require("lil-stats")
require("lil-subs")
require("lil-windows")
--minidoc_afterlines_end
