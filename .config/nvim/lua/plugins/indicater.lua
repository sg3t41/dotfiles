return {
	{
		"delphinus/skkeleton_indicator.nvim",
		config = function()
			vim.cmd([[ lua require("skkeleton_indicator").setup{}]])
		end
	},
}
