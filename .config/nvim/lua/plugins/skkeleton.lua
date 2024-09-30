return {
	{
		"vim-skk/skkeleton",
		dependencies = { "vim-denops/denops.vim", "Shougo/ddc.vim" },

		config = function()
			vim.fn['skkeleton#config']({
				globalDictionaries = {
					"~/.skk/SKK-JISYO.L",
				},
				eggLikeNewline = true,
				keepState = true,
				registerConvertResult = true,
				showCandidatesCount = 1,
				databasePath = "~/.skk/SKK-JISYO.L",
				debug = false,
				immediatelyDictionaryRW = false
			})

			vim.fn['skkeleton#register_keymap']('input', '<CR>', function() end)
			vim.fn['skkeleton#register_keymap']('henkan', '<CR>', function() end)
			vim.fn['ddc#custom#patch_global']('sources', { 'skkeleton' })
			vim.fn['ddc#custom#patch_global']('sourceOptions', {
				_ = {
					matchers = { 'matcher_head' },
					sorters = { 'sorter_rank' },
				},
				skkeleton = {
					mark = 'skkeleton',
					matchers = {},
					sorters = {},
					converters = {},
					isVolatile = true,
					minAutoCompleteLength = 1,
				}
			})

			vim.fn['ddc#enable']()

			vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(skkeleton-enable)', { noremap = true })
			vim.api.nvim_set_keymap('c', '<C-j>', '<Plug>(skkeleton-enable)', { noremap = true })
			vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>(skkeleton-disable)', { noremap = true })
			vim.api.nvim_set_keymap('c', '<C-l>', '<Plug>(skkeleton-disable)', { noremap = true })
		end
	},
}
