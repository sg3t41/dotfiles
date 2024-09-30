local Plugin = { "akinsho/bufferline.nvim" }

Plugin.event = "VeryLazy"

Plugin.opts = {
	options = {
		mode = "buffers",
		color_icons = false,
		show_buffer_icons = false,
		show_buffer_close_icons = false,
		show_close_icon = false,

		indicator = {
			icon = "",
			style = "icon",
		},

		modified_icon = "[+]",
		left_trunc_marker = "",
		right_trunc_marker = "",

		offsets = {
			-- show current branch name
			{
				filetype = "NvimTree",
				text = function()
					local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
					if branch ~= "" then
						return "*" .. branch
					end
					return "[No branch]"
				end,
				highlight = "@markup.heading",
				separator = true,
			},
		},
	},

	highlights = {
		buffer_selected = {
			italic = false,
		},
		indicator_selected = {
			fg = { attribute = "fg", highlight = "Function" },
			italic = false,
		},
	},
}

Plugin.keys = {
	{ "<leader>bc", "<cmd>BufferLinePickClose<cr>" },
	{ ">",          "<cmd>BufferLineCycleNext<cr>" },
	{ "<",          "<cmd>BufferLineCyclePrev<cr>" },
}

return Plugin
