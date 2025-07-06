local Plugin = { "smoka7/hop.nvim" }
Plugin.enabled = false  -- LSPのgoto機能で十分

Plugin.version = "v2"

Plugin.lazy = true

Plugin.config = function()
	require("hop").setup({
		keys = "etovxqpdygfblzhckisuran",
	})
end

Plugin.keys = {
	-- { "<leader><leader>", "<cmd>HopWord<cr>" },
	{ "<leader>j", "<cmd>HopWord<cr>" },
}

return Plugin
