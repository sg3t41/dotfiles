local Plugin = { "nvim-treesitter/nvim-treesitter" }
Plugin.enabled = true
Plugin.build = ":TSUpdate"
Plugin.lazy = false

Plugin.cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" }

function Plugin.init(plugin)
	require("lazy.core.loader").add_to_rtp(plugin)
	require("nvim-treesitter.query_predicates")
end

Plugin.opts = {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	auto_install = true,
	sync_install = true,
	ensure_installed = "all",
}

return Plugin
