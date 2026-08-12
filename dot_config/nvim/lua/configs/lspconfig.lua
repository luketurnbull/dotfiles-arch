require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("qmlls", {
	cmd = { "qmlls6" },
})

local servers = { "html", "cssls", "clangd", "qmlls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
