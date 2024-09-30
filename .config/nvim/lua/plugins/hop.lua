local Plugin = { "smoka7/hop.nvim" }

Plugin.version = "v2"
Plugin.lazy = true
function Plugin.config()
	require("hop").setup({
		keys = "etovxqpdygfblzhckisuran",
	})
end

Plugin.keys = {
	{ "<leader>h", "<cmd>HopWord<cr>" },
	{ "<leader>j", "<cmd>HopChar2<cr>" },
}

return Plugin
