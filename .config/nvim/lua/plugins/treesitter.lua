local Plugin = { "nvim-treesitter/nvim-treesitter" }
Plugin.enabled = false -- 無効化(要らない説)

Plugin.build = ":TSUpdate"

Plugin.lazy = true

Plugin.cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" }

function Plugin.init(plugin)
	require("lazy.core.loader").add_to_rtp(plugin)
	require("nvim-treesitter.query_predicates")
end

Plugin.opts = {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	auto_install = true,
	sync_install = true,
	ensure_installed = {
		"go",
		"omnisharp",
		"c",
		"diff",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"jsonc",
		"lua",
		"luadoc",
		"luap",
		"markdown",
		"markdown_inline",
		"printf",
		"python",
		"query",
		"regex",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"xml",
		"yaml",
	},
}

return Plugin
