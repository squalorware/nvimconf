require("nvim-treesitter.configs").setup({
    auto_install = false,
    ensure_installed = {
        "asm", "bash", "c",
        "css","csv", "desktop",
        "dockerfile", "go", "html",
        "javascript", "lua", "markdown",
        "markdown_inline", "nginx", "python",
        "query", "ruby", "vim",
        "vimdoc", "xml", "yaml", "zig"
    },
    highlight = {
        additional_vim_regex_highlighting = false,
        disable = function (_, bufnr)
            local max_filesize = 512 * 1024 -- 512 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))

            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        enable = true,
    },
    sync_install = true,
})
