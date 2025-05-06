vim.g.mapleader = " "

-- Terminal key combinations
vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>")
vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm<CR>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-N><C-w>", { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<cmd>NvimTreeToggle<CR>")
