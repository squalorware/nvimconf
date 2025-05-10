local lualine = require("lualine")
local palette = require("guizi.palette")
local guizi = require("lualine.themes.guizi")
local pl_strings = require("plenary.strings")

local conditions = {
    buffer_not_empty = function ()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function ()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function ()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end
}

local config = {
    options = {
        component_separators = guizi.component_separators,
        icons_enabled = true,
        section_separators = guizi.component_separators,
        theme = guizi.theme
    },
    sections = {
        lualine_a = {
            {
                function()
                    return "▊"
                end,
                color = { fg = palette.bright.yellow },
                padding = { left = 0, right = 1 },
            },
            {
                "mode",
                color = function ()
                    return guizi.editor_mode[vim.fn.mode()]
                end,
                padding = { left = 1, right = 1 }
            }
        },
        lualine_b = {
            {
                "branch",
                fmt = function(str)
                    return pl_strings.truncate(str, 30)
                end,
                color = { fg = palette.bright.yellow, bg = palette.bright.blue, gui = "bold" },
                cond = conditions.check_git_workspace,
            },
            {
                "diff",
                diff_color = {
                    added = { fg = palette.green },
                    modified = { fg = palette.orange },
                    removed = { fg = palette.red },
                },
                cond = conditions.check_git_workspace,
            },
            "diagnostics",
        },
        lualine_c = {
            {
                "filename",
                cond = conditions.buffer_not_empty,
                color = { fg = palette.magenta, gui = "bold" },
                path = 1
            },
        },
        lualine_x = {
            {
                "encoding",
                fmt = string.upper,
                cond = conditions.hide_in_width,
                color = { fg = palette.white, gui = 'bold' },
            },
            {
                "fileformat",
                fmt = string.upper,
                icons_enabled = false,
                color = { fg = palette.bright.yellow, gui = "bold" }
            }
        },
        lualine_y = {
            {
                "datetime",
                style = "%d %b, %Y - %H:%M:%S",
                icons_enabled = false,
                color = {
                    fg = palette.black,
                    bg = palette.bright.yellow,
                    gui = "bold"
                }
            },
        },
        lualine_z = { "location" },
    }
}

lualine.setup(config)
