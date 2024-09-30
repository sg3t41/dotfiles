local Plugin = { "nvim-treesitter/nvim-treesitter" }
Plugin.enabled = true
Plugin.build = ":TSUpdate"
Plugin.lazy = vim.fn.argc(-1) == 0
Plugin.cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" }

function Plugin.init(plugin)
	require("lazy.core.loader").add_to_rtp(plugin)
	require("nvim-treesitter.query_predicates")
end

Plugin.keys = {
	{ "<c-space>", desc = "Increment Selection" },
	{ "<bs>",      desc = "Decrement Selection", mode = "x" },
}

Plugin.opts = {
	highlight = { enable = true },
	indent = { enable = false },
	ensure_installed = {
		"bash",
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
	incremental_selection = {
		enable = false,
	},
	textobjects = {
		move = {
			enable = false,
		},
	},
}

return Plugin
