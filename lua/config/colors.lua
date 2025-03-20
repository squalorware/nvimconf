local M = {}

M.palette = {
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

M.editor_mode = {
    n = {
        bg = M.palette.orange,
        fg = M.palette.bg
    },
    i = {
        bg = M.palette.cyan,
        fg = M.palette.bg
    },
    v = {
        bg = M.palette.yellow,
        fg = M.palette.bg
    },
    [""] = {
        bg = M.palette.blue,
        fg = M.palette.fg
    },
    V = {
        bg = M.palette.blue,
        fg = M.palette.fg
    },
    c = {
        bg = M.palette.magenta,
        fg = M.palette.fg
    },
    no = {
        bg = M.palette.red,
        fg = M.palette.fg
    },
    s = {
        bg = M.palette.cyan,
        fg = M.palette.bg
    },
    S = {
        bg = M.palette.cyan,
        fg = M.palette.bg
    },
    [""] = {
        bg = M.palette.cyan,
        fg = M.palette.bg
    },
    ic = {
        bg = M.palette.yellow,
        fg = M.palette.bg
    },
    R = {
        bg = M.palette.violet,
        fg = M.palette.fg
    },
    Rv = {
        bg = M.palette.violet,
        fg = M.palette.fg
    },
    cv = {
        bg = M.palette.red,
        fg = M.palette.fg
    },
    ce = {
        bg = M.palette.red,
        fg = M.palette.fg
    },
    r = {
        bg = M.palette.cyan,
        fg = M.palette.bg
    },
    rm = {
        bg = M.palette.cyan,
        fg = M.palette.bg
    },
    ["r?"] = {
        bg = M.palette.cyan,
        fg = M.palette.bg
    },
    ["!"] = {
        bg = M.palette.red,
        fg = M.palette.fg
    },
    t = {
        bg = M.palette.red,
        fg = M.palette.fg
    },
}

return M
