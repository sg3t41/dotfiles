local Plugin = { 'projekt0n/github-nvim-theme' }

Plugin.name = 'github-theme'
Plugin.lazy = false
Plugin.priority = 1000

function Plugin.config()
	vim.cmd('colorscheme github_dark_dimmed')
end

return Plugin
