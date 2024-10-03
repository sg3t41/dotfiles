local Plugin = { 'akinsho/toggleterm.nvim' }
--Plugin.lazy = true
Plugin.version = "*"
Plugin.opts = {
	direction = "float",
	autochdir = true,
	open_mapping = [[<c-\>]],
	shade_terminals = false,
	hide_numbers = true,
	start_in_insert = true,
	persist_size = true,
	persist_mode = true,
	close_on_exit = false,
	width = 100,
	float_opts = {
		border = 'curved',
		winblend = 0,
		title_pos = 'center',
	},
	highlights = {
		FloatBorder = {
			guifg = '#ffffff',
		},
		Normal = {
			guibg = '#ffffff',
		},
		NormalFloat = {
			link = 'Normal',
		},
	},
}

return Plugin
