-- Custom color palette
-- Inspired by vim94/ron theme

local M = {}

M.standard = {
    black = "#343434",
    white = "#efefef",
    grey = "#dcdcdc",
    red = "#9a0000",
    green = "#009a00",
    blue = "#00009a",
    yellow = "#9a9a00",
    cyan = "#009a9a",
    orange = "#dd8300",
    violet = "#5a009a",
    magenta = "#9a009a",
}

M.bright = {
    black = "#121212",
    white = "#fefefe",
    grey = "#cdcdcd",
    red = "#cd0000",
    green = "#00cd00",
    blue = "#0000cd",
    yellow = "#cdcd00",
    cyan = "#00cdcd",
    orange = "#ffa500",
    violet = "#7c00cd",
    magenta = "#cd00cd",
}

setmetatable(M, { __index = M.standard })

return M
