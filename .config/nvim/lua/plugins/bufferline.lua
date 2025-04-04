local Plugin = { "akinsho/bufferline.nvim" }

-- バッファを開いたときにロード
Plugin.event = "BufWinEnter"

Plugin.opts = {
	options = {
		mode = "buffers",
		color_icons = false,
		show_buffer_icons = false,
		show_buffer_close_icons = false,
		show_close_icon = false,

		indicator = {
			icon = "",
		},

		modified_icon = "*",
		left_trunc_marker = "",
		right_trunc_marker = "",
	},

	highlights = {
		buffer_selected = {
			italic = false,
		},
		indicator_selected = {
			-- 開いているバッファのファイル名の色
			fg = { attribute = "fg", highlight = "Function" },
			italic = false,
		},
	},
}

Plugin.keys = {
	{ "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "現在のバッファを閉じる" } },
	{ ">", "<cmd>BufferLineCycleNext<cr>", { desc = "次のバッファを表示" } },
	{ "<", "<cmd>BufferLineCyclePrev<cr>", { desc = "前のバッファを表示" } },
}

return Plugin
