local Plugin = { 'aliqyan-21/darkvoid.nvim' }
Plugin.lazy = true
Plugin.event = "VeryLazy"

Plugin.opts = {
	colors = {
		comment = "#c0c0c0"
	}
}

function Plugin.config()
	require('darkvoid').setup({
		transparent = false,
		glow = false,
		show_end_of_buffer = true,

		colors = {
			fg = "#c0c0c0",
			bg = "#1c1c1c",
			cursor = "#bdfe58",
			line_nr = "#404040",
			visual = "#303030",
			comment = "#6fd8ed",
			string = "#d1d1d1",
			func = "#e1e1e1",
			kw = "#f1f1f1",
			identifier = "#b1b1b1",
			type = "#a1a1a1",
			type_builtin = "#c5c5c5", -- current
			-- type_builtin = "#8cf8f7", -- glowy blue old (was present by default before type_builtin was introduced added here for people who may like it)
			search_highlight = "#ee836f",
			operator = "#1bfd9c",
			bracket = "#e6e6e6",
			preprocessor = "#4b8902",
			bool = "#66b2b2",
			constant = "#b2d8d8",

			-- enable or disable specific plugin highlights
			plugins = {
				gitsigns = true,
				nvim_cmp = true,
				treesitter = true,
				nvimtree = true,
				telescope = true,
				lualine = true,
				bufferline = true,
				oil = true,
				whichkey = true,
				nvim_notify = true,
			},

			-- gitsigns colors
			added = "#baffc9",
			changed = "#ffffba",
			removed = "#ffb3ba",

			-- Pmenu colors
			pmenu_bg = "#1c1c1c",
			pmenu_sel_bg = "#1bfd9c",
			pmenu_fg = "#c0c0c0",

			-- EndOfBuffer color
			eob = "#3c3c3c",

			-- Telescope specific colors
			border = "#585858",
			title = "#bdfe58",

			-- bufferline specific colors
			bufferline_selection = "#1bfd9c",

			-- LSP diagnostics colors
			error = "#dea6a0",
			warning = "#d6efd8",
			hint = "#bedc74",
			info = "#7fa1c3",
		},
	})
	-- Set colorscheme
	vim.cmd.colorscheme("darkvoid")

	-- 検索配色
	-- 検索中
	vim.api.nvim_set_hl(0, "Search", { fg = "#E73275" })
	-- 検索条件変更中の現在フォーカス該当文字列
	vim.api.nvim_set_hl(0, "IncSearch", { bg = "#E73275" })
	-- カーソル位置の検索結果
	vim.api.nvim_set_hl(0, "CurSearch", { bg = "#E73275" })

	-- Set individual highlights with styles
	vim.api.nvim_set_hl(0, "FloatBorder", { italic = true })
	-- NvimTreeのレイアウト調整
	vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { italic = true })
	vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { italic = true })

	vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#316745' })
end

return Plugin
