vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach (bufnr)
    local api = require("nvim-tree.api")

    local function opts (desc)
        return {
            buffer = bufnr,
            desc = "nvim-tree: " .. desc,
            noremap = true,
            nowait = true,
            silent = true,
        }
    end

    local function edit_or_open ()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
            api.node.open.edit()
        else
            api.node.open.edit()
            api.tree.close()
        end
    end

    local function vsplit_preview ()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
            api.node.open.edit()
        else
            api.node.open.vertical()
        end

        api.tree.focus()
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "l", edit_or_open, opts("Edit or Open"))
    vim.keymap.set("n", "L", vsplit_preview, opts("Vertical Split Preview"))
    vim.keymap.set("n", "h", api.tree.close, opts("Close"))
    vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
    vim.keymap.set('n', '<C-h><C-p>', api.tree.change_root_to_parent, opts('Go Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

vim.keymap.set("n", "<C-h>", "<cmd>NvimTreeToggle<CR>")

require("nvim-tree").setup({
    filters = {
        custom = {
            "^\\.git$",
            "^__pycache__$",
        },
    },
    renderer = {
        group_empty = true
    },
    sort = {
        sorter = "case_sensitive",
    },
    on_attach = my_on_attach,
    view = {
        width = 35
    },
})
