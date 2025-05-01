return {
	'kiddos/gemini.nvim',
	config = function()
		require('gemini').setup({
			instruction = {
				prompts = {
					{
						name = 'コードレビュー',
						command_name = 'GeminiCustomCodeReview', -- 新しいコマンド名
						menu = 'コードレビュー 📜',
						get_prompt = function(lines, bufnr)
							local code = vim.fn.join(lines, '\n')
							local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
							local prompt = '以下のコードをレビューしてください:\n\n```%s\n%s\n```\n\n'
									.. '目的: このコードの問題点を指摘し、改善案を提案してください。\n'
							return string.format(prompt, filetype, code)
						end,
					},
				}
			}
		})
	end
}
