local Plugin = { "nvim-tree/nvim-tree.lua" }

local config = require('plugins.nvimtree.config')
local keymaps = require('plugins.nvimtree.keymaps')

function Plugin.init()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
end

Plugin.keys = keymaps.setup()

Plugin.opts = {
	view = {
		float = {
			enable = true,
			open_win_config = config.get_float_config,
		},
		width = function()
			return math.floor(vim.opt.columns:get() * config.FLOAT_SIZE.width_ratio)
		end,
	},

	renderer = {
		root_folder_label = config.generate_label,
		add_trailing = true,
		highlight_git = true,
		icons = {
			show = {
				file = false,
				folder = false,
				folder_arrow = false,
				git = false,
			},
		},
	},

	git = {
		enable = true,
		ignore = false,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},

	hijack_directories = {
		enable = true,
		auto_open = true,
	},

	filters = {
		dotfiles = false,
		git_ignored = false,
	},
}

function Plugin.config()
	require('nvim-tree').setup(Plugin.opts)

	-- git状態ファイルの色を変更
	vim.defer_fn(function()
		vim.api.nvim_set_hl(0, "NvimTreeGitFileNewHL", { fg = "#FFD700" })       -- 新規: 金色
		vim.api.nvim_set_hl(0, "NvimTreeGitFileDirtyHL", { fg = "#00FF00" })     -- 変更済み: 明るい緑
		vim.api.nvim_set_hl(0, "NvimTreeGitFolderIgnoredHL", { fg = "#666666" }) -- 無視フォルダ: 灰色
		vim.api.nvim_set_hl(0, "NvimTreeGitFileIgnoredHL", { fg = "#666666" })   -- 無視ファイル: 灰色
	end, 100)
end

return Plugin

