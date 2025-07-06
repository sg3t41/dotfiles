local Plugin = { 'nvim-telescope/telescope.nvim' }

Plugin.dependencies = {
	{ 'natecraddock/telescope-zf-native.nvim', build = false },
}

Plugin.branch = '0.1.x'
Plugin.build = false
Plugin.lazy = true
Plugin.cmd = { 'Telescope' }

Plugin.keys = {
	{ '<leader>?', '<cmd>Telescope oldfiles<cr>', { desc = 'ファイル履歴を検索' } },
	{ '<leader>fv', '<cmd>Telescope buffers<cr>', { desc = '開いているファイルを検索' } },
	{ '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '全てのファイルを検索' } },
	{ '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'プロジェクト内を検索' } },
	{ '<leader>fd', '<cmd>Telescope diagnostics<cr>', { desc = '診断結果を検索' } },
	{ '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = '現在のバッファ内を検索' } }
}

function Plugin.config()
	pcall(require('telescope').load_extension, 'zf-native')
end

return Plugin

