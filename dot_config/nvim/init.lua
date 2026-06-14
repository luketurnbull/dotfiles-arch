require("vim._core.ui2").enable({})

require('options')
require('keymaps')
require('pack')

vim.cmd.colorscheme("tokyonight-night")

-- LSP
require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<Right>"] = { "select_and_accept", "fallback" },
    },
    apperance = { nerd_font_variable = "mono" },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true },
    },
})

require("conform").setup({
    formatters_by_ft = { lua = { "stylelua" } },
    format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format local buffer" })
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Format local buffer" })

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.enable({
    'lua_ls',
    'clangd'
})
