-- Ported from nvim-colorscheme-template by datsfilipe
-- https://github.com/datsfilipe/nvim-colorscheme-template/blob/main/lua/my-theme/config.lua

local M = {}

M.defaults = {
    theme = "dark",
    transparent = false,
    italics = {
        comments = false,
        keywords = false,
        functions = false,
        strings = false,
        variables = false,
        bufferline = false,
    },
}

M.overrides = {}

setmetatable(M, { __index = M.defaults })

return M
