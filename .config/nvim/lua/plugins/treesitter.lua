local Plugin = { "nvim-treesitter/nvim-treesitter" }
Plugin.build = ":TSUpdate"
Plugin.lazy = false


Plugin.cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" }

function Plugin.init(plugin)
	require("lazy.core.loader").add_to_rtp(plugin)
	require("nvim-treesitter.query_predicates")
end

Plugin.opts = {
	highlight = {
		enable = false,
		additional_vim_regex_highlighting = false,
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
