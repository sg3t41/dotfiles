-- Space as leader key
vim.g.mapleader = " "

-- Shortcuts
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>", { desc = "全文選択" })

-- Copy Paste
vim.keymap.set({ "n", "x" }, "y", '"+y', { desc = "クリップボードにコピー" })
vim.keymap.set({ "n", "x" }, "p", '"+p', { desc = "クリップボードの内容を貼り付け" })

-- Commands
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "保存" })
vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "ファイルを閉じる" })
vim.keymap.set("n", "<leader>bn", "<cmd>buffer #<cr>", { desc = "直前のバッファに移動" })
vim.keymap.set({ "i", "l" }, "jj", "<Esc>", { desc = "ノーマルモードへ移行" })

vim.keymap.set("n", "<leader>csvim", "<cmd>CheatsheetVim<cr>", { desc = "Vimのチートシートを開く" })
