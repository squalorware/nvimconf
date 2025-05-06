-- Ported from nvim-colorscheme-template by datsfilipe
-- https://github.com/datsfilipe/nvim-colorscheme-template/blob/main/lua/my-theme/utils.lua

local M = {}

local function hex_to_rgb(hex)
    local hex_type = "[abcdef0-9][abcdef0-9]"
    local p = "^#(" .. hex_type .. ")(" .. hex_type .. ")(" .. hex_type .. ")$"

    assert(
        string.find(hex, p) ~= nil,
        "hex_to_rgb: invalid hex: " .. tostring(hex)
    )

    local red, green, blue = string.match(hex, p)
    return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

function M.mix(fg, bg, alpha)
    bg = hex_to_rgb(bg)
    fg = hex_to_rgb(fg)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format(
        "#%02X%02X%02X",
        blendChannel(1),
        blendChannel(2),
        blendChannel(3)
    )
end

function M.shade(color, value, base)
    if base == nil then
        base = "#ffffff"
    end

    return M.mix(color, base, math.abs(value))
end

return M
