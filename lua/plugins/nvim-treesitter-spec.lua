local function treesitter_config()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "xml", "html", "javascript", "python",
            "go", "nginx", "zig", "bash", "asm", "css", "csv", "desktop", "dockerfile", "ruby", "yaml" },
        auto_install = true,
        highlight = {
            enable = true,
            disable = function (lang, buf)
                local max_filesize = 512 * 1024 -- 512 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false
        }
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = true,
    config = treesitter_config
}
