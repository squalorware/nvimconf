local mason_installer = require("mason-tool-installer")

mason_installer.setup({
    ensure_installed = {
        "stylua",
        "prettier"
    }
})
