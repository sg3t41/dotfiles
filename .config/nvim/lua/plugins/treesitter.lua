local Plugin = { "nvim-treesitter/nvim-treesitter" }
-- うまく効かない為、いったん無効
Plugin.enabled = false
Plugin.build = ":TSUpdate"
Plugin.lazy = false

Plugin.cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" }

function Plugin.init(plugin)
	require("lazy.core.loader").add_to_rtp(plugin)
	require("nvim-treesitter.query_predicates")
end

Plugin.opts = {
	highlight = { enable = true },
	indent = { enable = false },
	ensure_installed = {
		"bash",
		"c",
		"diff",
		"html",
		"javascript",
		"go",
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
