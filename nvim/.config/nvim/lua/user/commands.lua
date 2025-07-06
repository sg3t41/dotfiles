local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", {})

vim.api.nvim_create_user_command("TrailspaceTrim", function()
	-- Save cursor position to later restore
	local curpos = vim.api.nvim_win_get_cursor(0)

	-- Search and replace trailing whitespace
	vim.cmd([[keeppatterns %s/\s\+$//e]])
	vim.api.nvim_win_set_cursor(0, curpos)
end, { desc = "Delete extra whitespace" })

local cheatsheet_path = "~/.config/nvim/cheatsheet/vim.txt"
vim.api.nvim_create_user_command("CheatsheetVim", function()
	vim.cmd("edit " .. cheatsheet_path)
end, {})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man" },
	group = group,
	command = "nnoremap <buffer> q <cmd>quit<cr>",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Format on save",
	group = group,
	-- 	buffer = event.buf,
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
