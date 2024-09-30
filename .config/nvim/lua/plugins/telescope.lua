local Plugin = { 'nvim-telescope/telescope.nvim' }

Plugin.dependencies = {
	{ 'natecraddock/telescope-zf-native.nvim', build = false },
}

Plugin.branch = '0.1.x'
Plugin.build = false
Plugin.lazy = true
Plugin.cmd = { 'Telescope' }

Plugin.keys = {
	{ '<leader>?',  '<cmd>Telescope oldfiles<cr>',                  { desc = 'Search file history' } },
	{ '<leader>fv', '<cmd>Telescope buffers<cr>',                   { desc = 'Search open files' } },
	{ '<leader>ff', '<cmd>Telescope find_files<cr>',                { desc = 'Search all files' } },
	{ '<leader>fg', '<cmd>Telescope live_grep<cr>',                 { desc = 'Search in project' } },
	{ '<leader>fd', '<cmd>Telescope diagnostics<cr>',               { desc = 'Search diagnostics' } },
	{ '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = 'Buffer local search' } }
}

function Plugin.config()
	pcall(require('telescope').load_extension, 'zf-native')
end

return Plugin
