local lsp_zero = require("lsp-zero")
local cmp = require("cmp")
local telescope_builtin = require("telescope.builtin")

local function opts (bufnr, desc)
    return {
        buffer = bufnr,
        desc = "lsp: " .. desc,
        noremap = true,
        nowait = true,
        silent = true
    }
end

local function my_on_attach (_, bufnr)
    vim.keymap.set("n", "K", function ()
        vim.lsp.buf.hover()
    end, opts(bufnr, "Hover"))
    vim.keymap.set("n", "gd", function ()
        telescope_builtin.lsp_definitions()
    end, opts(bufnr, "Show definitions"))
    vim.keymap.set("n", "gD", function ()
        vim.lsp.buf.declaration()
    end, opts(bufnr, "Show declarations"))
    vim.keymap.set("n", "gi", function ()
        telescope_builtin.lsp_implementations()
    end, opts(bufnr, "Show implementations"))
    vim.keymap.set("n", "gI", function ()
        telescope_builtin.lsp_incoming_calls()
    end, opts(bufnr, "Incoming calls"))
    vim.keymap.set("n", "go", function ()
        telescope_builtin.lsp_type_definitions()
    end, opts(bufnr, "Show type definitions"))
    vim.keymap.set("n", "gO", function ()
        telescope_builtin.lsp_outgoing_calls()
    end, opts(bufnr, "Outgoing calls"))

    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts(bufnr, "Add directory to workspace"))
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts(bufnr, "Remove directory from workspace"))
    vim.keymap.set("n", "<leader>wl", function ()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts(bufnr, "List directories in workspace"))
    vim.keymap.set("n", "<leader>ws", function ()
        telescope_builtin.lsp_workspace_symbols()
    end, opts(bufnr, "Show workspace symbols"))
    vim.keymap.set("n", "<leader>ds", function ()
        telescope_builtin.lsp_document_symbols()
    end, opts(bufnr, "Show document symbols"))

    vim.keymap.set("n", "<leader>vd", function ()
        telescope_builtin.diagnostics({ bufnr = 0 })
    end, opts(bufnr, "Toggle diagnostics"))
    vim.keymap.set("n", "<leader>wd", function ()
        telescope_builtin.diagnostics()
    end, opts(bufnr, "Toggle diagnostics"))
    vim.keymap.set("n", "]d", function ()
        vim.diagnostic.goto_next()
    end, opts(bufnr, "Go to next symbol"))
    vim.keymap.set("n", "[d", function ()
        vim.diagnostic.goto_prev()
    end, opts(bufnr, "Go to previous symbol"))
    vim.keymap.set({ "n", "v" }, "<leader>ca", function ()
        vim.lsp.buf.code_action()
    end, opts(bufnr, "Select action"))
    vim.keymap.set("n", "<leader>vr", function ()
        local function my_on_list (options)
            vim.fn.setqflist({}, " ", options)
            telescope_builtin.quickfix()
        end
        vim.lsp.buf.references(
            { includeDeclaration = false },
            { on_list = my_on_list }
        )
    end, opts(bufnr, "Quick fixes"))
    vim.keymap.set("n", "<leader>vn", function ()
        vim.lsp.buf.rename()
    end, opts(bufnr, "Rename"))
    vim.keymap.set("i", "<C-h>", function ()
        vim.lsp.buf.signature_help()
    end, opts(bufnr, "Show signature help"))
    vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts(bufnr, "Restart LSP"))
    vim.keymap.set("n", "<leader>fs", "<cmd>LspStart<CR>", opts(bufnr, "Start LSP"))
    vim.keymap.set("n", "<leader>hrs", function ()
        local detach_clients = {}
        local clients = require("lspconfig.util").get_lsp_clients({ bufnr = bufnr })

        for _, client in ipairs(clients) do
            if client.attached_buffers[bufnr] then
                detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
                client.stop(true)
                local timer = vim.loop.new_timer()
                timer:start(
                    500, 100,
                    vim.schedule_wrap(function ()
                        for client_name, tuple in pairs(detach_clients) do
                            if require("lspconfig.configs")[client_name] then
                                local client, attached_buffers = table.unpack(tuple)

                                if client.is_stopped() then
                                    for _, buf in pairs(attached_buffers) do
                                        require("lspconfig.configs")[client_name].launch(buf)
                                    end
                                    detach_clients[client_name] = nil
                                end
                            end
                        end

                        if next(detach_clients) == nil and not timer:is_closing() then
                            timer:close()
                        end
                    end)
                )
            end
        end
    end, opts(bufnr, "Detach clients"))
end

lsp_zero.on_attach(my_on_attach)
require("lspconfig").mojo.setup({
    on_attach = my_on_attach
})

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "pylsp",
        "lua_ls",
        "docker_compose_language_service",
        "dockerls",
        "marksman",
        "sqlls",
        "html",
        "bashls"
    },
    automatic_installation = true,
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function ()
            require("neodev").setup({})
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
        end,
        pylsp = function ()
            require("lspconfig").pylsp.setup({
                settings = {
                    pylsp = {
                        plugins = {
                            rope_autoimport = {
                                enabled = true,
                                memory = true,
                            },
                            rope_completion = {
                                enabled = true
                            },
                            ruff = {
                                enabled = true,
                                formatEnabled = true,
                                format = { "I" },
                                extendSelect = { "ALL" },
                                extendIgnore = { "CPY", "ANN", "D", "PL", "FA" },
                                extendFixable = { "ALL" },
                                unsafeFixes = true,
                                linelength = 80,
                                preview = true
                            },
                            pylsp_mypy = {
                                enabled = true,
                                live_mode = true,
                                strict = true,
                            },
                        },
                    },
                },
            })
        end,
    },
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "nvim_lua" },
        { name = "buffer", keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-i>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace
        }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-q>"] = cmp.mapping.close()
    }),
})
