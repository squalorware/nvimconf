local telescope = require("telescope")
local actions = require("telescope.actions")

local function opts (desc)
    return { desc = "nvim-telescope: " .. desc }
end

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<Esc>"] = actions.close,
            },
        },
    },
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, opts("Find files"))
vim.keymap.set("n", "<leader>pgf", builtin.git_files, opts("Browse git files"))
vim.keymap.set("n", "<leader>pbf", builtin.git_branches, opts("Browse local git branches"))
vim.keymap.set("n", "<leader>pgq", builtin.git_status, opts("Show current git status"))
