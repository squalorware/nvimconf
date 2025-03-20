local lualine = require("lualine")
local pl_strings = require("plenary.strings")

local color_scheme = require("config.colors")

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
        component_separators = { left = '', right = ''},
        icons_enabled = true,
        section_separators = { left = '', right = ''},
        theme = {
            normal = {
                a = { fg = color_scheme.palette.fg, bg = color_scheme.palette.bg },
                b = { fg = color_scheme.palette.fg, bg = color_scheme.palette.bg },
                c = { fg = color_scheme.palette.fg, bg = color_scheme.palette.bg },
                x = { fg = color_scheme.palette.fg, bg = color_scheme.palette.bg },
                y = { fg = color_scheme.palette.fg, bg = color_scheme.palette.bg },
                z = { fg = color_scheme.palette.fg, bg = color_scheme.palette.bg }
            }
        }
    },
    sections = {
        lualine_a = {
            {
                function()
                    return "▊"
                end,
                color = { fg = color_scheme.palette.yellow },
                padding = { left = 0, right = 1 },
            },
            {
                "mode",
                color = function ()
                    return color_scheme.editor_mode[vim.fn.mode()]
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
                color = { fg = color_scheme.palette.yellow, bg = color_scheme.palette.darkblue, gui = "bold" },
                cond = conditions.check_git_workspace,
            },
            {
                "diff",
                diff_color = {
                    added = { fg = color_scheme.palette.green },
                    modified = { fg = color_scheme.palette.orange },
                    removed = { fg = color_scheme.palette.red },
                },
                cond = conditions.check_git_workspace,
            },
            "diagnostics",
        },
        lualine_c = {
            {
                "filename",
                cond = conditions.buffer_not_empty,
                color = { fg = color_scheme.palette.magenta, gui = "bold" },
                path = 1
            },
        },
        lualine_x = {
            {
                "encoding",
                fmt = string.upper,
                cond = conditions.hide_in_width,
                color = { fg = color_scheme.palette.fg, gui = 'bold' },
            },
            {
                "fileformat",
                fmt = string.upper,
                icons_enabled = false,
                color = { fg = color_scheme.palette.yellow, gui = "bold" }
            }
        },
        lualine_y = {
            {
                "datetime",
                style = "%d %b, %Y %H:%M:%S",
                color = {
                    fg = color_scheme.palette.bg,
                    bg = color_scheme.palette.yellow,
                    gui = "bold"
                }
            },
        },
        lualine_z = { "location" },
    }
}

lualine.setup(config)
