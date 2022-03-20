local M = {}

--- Magical module loader
-- Dependencies are installed and sourced if not already. No restart necessary.
M.setup_module = function(module, plugins)
	local run_post_install = false
	local plugins_path = vim.fn.stdpath('data') .. '/site/pack/lil/start'

	for _, plugin in ipairs(plugins) do
		local install_path = plugins_path .. '/' .. plugin:gsub('/', '_')
		if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
			print('(lil): Downloading ' .. plugin)

			vim.fn.execute(
				'!git clone --depth 1 https://github.com/'
					.. plugin
					.. ' '
					.. install_path
			)

			-- At least one plugin has been installed
			run_post_install = true
		end
	end

	if run_post_install then
		vim.cmd('packloadall')
	end

	pcall(module)
end

return M
