local lualine = require("lualine")
local palette = require("guizi.palette")
local pl_strings = require("plenary.strings")


local editor_mode = {
    n = {
        bg = palette.bright.orange,
        fg = palette.black
    },
    i = {
        bg = palette.cyan,
        fg = palette.black
    },
    v = {
        bg = palette.bright.yellow,
        fg = palette.black
    },
    [""] = {
        bg = palette.bright.blue,
        fg = palette.black
    },
    V = {
        bg = palette.blue,
        fg = palette.white
    },
    c = {
        bg = palette.magenta,
        fg = palette.white
    },
    no = {
        bg = palette.red,
        fg = palette.white
    },
    s = {
        bg = palette.cyan,
        fg = palette.black
    },
    S = {
        bg = palette.bright.cyan,
        fg = palette.black
    },
    [""] = {
        bg = palette.bright.cyan,
        fg = palette.bright.black
    },
    ic = {
        bg = palette.bright.yellow,
        fg = palette.black
    },
    R = {
        bg = palette.violet,
        fg = palette.white
    },
    Rv = {
        bg = palette.bright.violet,
        fg = palette.bright.white
    },
    cv = {
        bg = palette.red,
        fg = palette.white
    },
    ce = {
        bg = palette.bright.red,
        fg = palette.bright.white
    },
    r = {
        bg = palette.cyan,
        fg = palette.black
    },
    rm = {
        bg = palette.cyan,
        fg = palette.black
    },
    ["r?"] = {
        bg = palette.bright.cyan,
        fg = palette.bright.black
    },
    ["!"] = {
        bg = palette.red,
        fg = palette.white
    },
    t = {
        bg = palette.red,
        fg = palette.white
    },
}

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
                a = { fg = palette.white, bg = palette.black },
                b = { fg = palette.white, bg = palette.black },
                c = { fg = palette.white, bg = palette.black },
                x = { fg = palette.white, bg = palette.black },
                y = { fg = palette.white, bg = palette.black },
                z = { fg = palette.white, bg = palette.black }
            }
        }
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
                    return editor_mode[vim.fn.mode()]
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
