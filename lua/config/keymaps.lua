local api = vim.api

api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>>]], { silent = true, noremap = true })
api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
