local lualine = require("plugins.lualine-spec")
local nvim_tree = require("plugins.nvim-tree-spec")
local treesitter = require("plugins.nvim-treesitter-spec")

return {
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
    },
    lualine,
    nvim_tree,
    treesitter
}
