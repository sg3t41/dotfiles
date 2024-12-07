vim.opt.number = false
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = false
vim.opt.shortmess:append("I")
vim.opt.autowriteall = true
vim.o.statusline = ""
vim.o.laststatus = 0
vim.o.cmdheight = 0
vim.opt.fillchars = { eob = " " }
vim.opt.termguicolors = true
vim.o.shell = "/bin/bash"

-- コンテナとホスト間のコピペでOSC52シーケンスを使用するための設定
--vim.g.clipboard = {
--	name = 'OSC 52',
--	copy = {
--		['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--		['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--	},
--	paste = {
--		['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--		['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--	},
--}

vim.cmd("syntax enable")
vim.cmd([[autocmd BufEnter * :TSBufEnable highlight]])
