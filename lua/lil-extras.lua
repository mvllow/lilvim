--- lil-extras.lua
--- https://github.com/mvllow/lilvim
---
--- Setup not so lil enhancements. This includes plugins to replace or improve
--- built-in functionality.

local use = require("lil-helpers").use

use({
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup({
			plugins = {
				spelling = {
					enabled = true,
				},
			},
		})
	end,
})

use({
	"kyazdani42/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				api.config.mappings.default_on_attach(bufnr)
				vim.keymap.set("n", "d", api.fs.trash, { buffer = bufnr })
			end,
			actions = { open_file = { quit_on_open = true } },
			git = { ignore = false },
			renderer = { icons = { show = { file = false, folder = false, folder_arrow = false, git = false } } },
			trash = { cmd = "trash" },
			view = { side = "right" },
		})
	end,
})

-- Toggle file tree at your current file.
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>", {
	desc = "Toggle file tree",
	silent = true,
})
