local Plugin = { "folke/tokyonight.nvim" }
Plugin.name = 'tokyonight'
Plugin.lazy = false
Plugin.priority = 1000
function Plugin.config()
	vim.cmd('colorscheme tokyonight')
end

return Plugin
