local Plugin = { "delphinus/skkeleton_indicator.nvim" }

function Plugin.config()
	vim.cmd([[ lua require("skkeleton_indicator").setup{}]])
end

return Plugin
