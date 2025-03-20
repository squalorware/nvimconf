local pl_strings = require("plenary.strings")
local lualine = require("lualine")

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

local colors = {
    bg = "#343434",
    fg = "#cdcdcd",
    yellow = "#cdcd00",
    cyan = "#007ccd",
    darkblue = "#00009a",
    green = "#00cd00",
    orange = "#ffa500",
    violet = "#7c00cd",
    magenta = "#cd00cd",
    blue = "#0000cd",
    red = "#cd0000",
}

local mode_color = {
    n = {
        bg = colors.orange,
        fg = colors.bg
    },
    i = {
        bg = colors.cyan,
        fg = colors.bg
    },
    v = {
        bg = colors.yellow,
        fg = colors.bg
    },
    [''] = {
        bg = colors.blue,
        fg = colors.fg
    },
    V = {
        bg = colors.blue,
        fg = colors.fg
    },
    c = {
        bg = colors.magenta,
        fg = colors.fg
    },
    no = {
        bg = colors.red,
        fg = colors.fg
    },
    s = {
        bg = colors.cyan,
        fg = colors.bg
    },
    S = {
        bg = colors.cyan,
        fg = colors.bg
    },
    [''] = {
        bg = colors.cyan,
        fg = colors.bg
    },
    ic = {
        bg = colors.yellow,
        fg = colors.bg
    },
    R = {
        bg = colors.violet,
        fg = colors.fg
    },
    Rv = {
        bg = colors.violet,
        fg = colors.fg
    },
    cv = {
        bg = colors.red,
        fg = colors.fg
    },
    ce = {
        bg = colors.red,
        fg = colors.fg
    },
    r = {
        bg = colors.cyan,
        fg = colors.bg
    },
    rm = {
        bg = colors.cyan,
        fg = colors.bg
    },
    ['r?'] = {
        bg = colors.cyan,
        fg = colors.bg
    },
    ['!'] = {
        bg = colors.red,
        fg = colors.fg
    },
    t = {
        bg = colors.red,
        fg = colors.fg
    },
}

local config = {
    options = {
        component_separators = { left = '', right = ''},
        icons_enabled = true,
        section_separators = { left = '', right = ''},
        theme = {
            normal = {
                a = { fg = colors.fg, bg = colors.bg },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
                x = { fg = colors.fg, bg = colors.bg },
                y = { fg = colors.fg, bg = colors.bg },
                z = { fg = colors.fg, bg = colors.bg }
            }
        }
    },
    sections = {
        lualine_a = {
            {
                function()
                    return "▊"
                end,
                color = { fg = colors.yellow },
                padding = { left = 0, right = 1 },
            },
            {
                "mode",
                color = function ()
                    return mode_color[vim.fn.mode()]
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
                color = { fg = colors.yellow, bg = colors.darkblue, gui = "bold" },
                cond = conditions.check_git_workspace,
            },
            {
                "diff",
                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.orange },
                    removed = { fg = colors.red },
                },
                cond = conditions.check_git_workspace,
            },
            "diagnostics",
        },
        lualine_c = {
            {
                "filename",
                cond = conditions.buffer_not_empty,
                color = { fg = colors.magenta, gui = "bold" },
                path = 1
            },
        },
        lualine_x = {
            {
                "encoding",
                fmt = string.upper,
                cond = conditions.hide_in_width,
                color = { fg = colors.fg, gui = 'bold' },
            },
            {
                "fileformat",
                fmt = string.upper,
                icons_enabled = false,
                color = { fg = colors.yellow, gui = "bold" }
            }
        },
        lualine_y = {
            {
                "datetime",
                style = "%d %b, %Y %H:%M:%S",
                color = {
                    fg = colors.bg,
                    bg = colors.yellow,
                    gui = "bold"
                }
            },
        },
        lualine_z = { "location" },
    }
}

lualine.setup(config)
