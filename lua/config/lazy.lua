local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        repo,
        lazypath
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    checker = {
        enabled = true
    },
    install = {
        colorscheme = { "ron" }
    },
    spec = {
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
        },
        {
            "nvim-lua/plenary.nvim",
        },
        {
            "akinsho/bufferline.nvim",
            lazy = true,
            dependencies = {
                "nvim-tree/nvim-web-devicons"
            },
        },
        {
            "nvim-lualine/lualine.nvim",
            lazy = true,
            dependencies = {
                "nvim-tree/nvim-web-devicons"
            },
        },
        {
            "nvim-tree/nvim-tree.lua",
            version = "*",
            lazy = false,
            dependencies = {
                "nvim-tree/nvim-web-devicons"
            },
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            lazy = true,
        },
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
        },
        {
            "https://github.com/nvim-treesitter/nvim-treesitter-context",
        },
        {
            "hiphish/rainbow-delimiters.nvim",
        },
    }
})
