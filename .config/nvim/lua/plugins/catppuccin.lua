local Plugin = { "catppuccin/nvim" }
Plugin.lazy = false
Plugin.priority = 1000
function Plugin.config()
	vim.cmd.colorscheme "catppuccin"
end

return Plugin

