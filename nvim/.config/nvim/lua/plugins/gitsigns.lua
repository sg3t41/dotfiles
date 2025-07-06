local Plugin = { "lewis6991/gitsigns.nvim" }
Plugin.lazy = true
Plugin.event = { "BufReadPre", "BufNewFile" }

Plugin.opts = {
	signs = {
		add = { text = "+" },
		change = { text = "*" },
		delete = { text = "-" },
		topdelete = { text = "-" },
		changedelete = { text = "*" },
	},
}

return Plugin
