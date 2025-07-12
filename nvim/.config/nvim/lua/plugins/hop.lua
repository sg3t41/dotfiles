local Plugin = { "smoka7/hop.nvim" }

Plugin.version = "v2"

Plugin.lazy = true

Plugin.config = function()
	require("hop").setup({
		keys = "etovxqpdygfblzhckisuran",
	})
end

Plugin.keys = {
	-- { "<leader><leader>", "<cmd>HopWord<cr>" },
	{ "<leader><leader>", "<cmd>HopWord<cr>" },
}

return Plugin
