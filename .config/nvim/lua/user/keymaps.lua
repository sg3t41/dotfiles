-- Space as leader key
vim.g.mapleader = " "

-- Shortcuts
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>", { desc = "Select all text in buffer" })

-- Basic clipboard interaction
-- This setting replaces the need for custom clipboard key mappings
-- user/serttigs.lua -> vim.opt.clipboard = "unnamedplus"
--vim.keymap.set({ "n", "x" }, "y", '"+y', { desc = "Copy to clipboard" })
--vim.keymap.set({ "n", "x" }, "p", '"+p', { desc = "Paste clipboard content" })

-- Commands
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>bq", "<cmd>bdelete<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bl", "<cmd>buffer #<cr>", { desc = "Go to last active buffer" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Change to nomal mode" })


vim.keymap.set({ "i", "c" }, [[<C-j>]], [[<Plug>(skkeleton-toggle)]], { noremap = false })
--vim.keymap.set({ "i", "c" }, [[<C-n>]], "<cmd>call pum#map#insert_relative(+1)<CR>")
--vim.keymap.set({ "i", "c" }, [[<C-p>]], "<cmd>call pum#map#insert_relative(-1)<CR>")
--vim.keymap.set({ "i", "c" }, [[<C-y>]], "<cmd>call pum#map#confirm()<CR>")
--vim.keymap.set({ "i", "c" }, [[<C-e>]], "<cmd>call pum#map#cancel()<CR>")
--vim.keymap.set({ "i", "c" }, [[<PageDown>]], "<cmd>call pum#map#insert_relative_page(+1)<CR>")
--vim.keymap.set({ "i", "c" }, [[<PageUp>]], "<cmd>call pum#map#insert_relative_page(-1)<CR>")
