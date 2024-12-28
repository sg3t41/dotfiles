local Plugin = { "smoka7/hop.nvim" }

Plugin.version = "v2"
Plugin.lazy = true
function Plugin.config()
	require("hop").setup({
		keys = "etovxqpdygfblzhckisuran",
	})
end

Plugin.keys = {
	{ "<leader><leader>", "<cmd>HopWord<cr>" },
	{ "<leader>h",        "<cmd>HopWord<cr>" },
}

return Plugin
