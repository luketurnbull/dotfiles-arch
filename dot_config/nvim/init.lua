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
    formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier", "biome", "oxfmt", stop_after_first = true },
        javascriptreact = { "prettier", "biome", "oxfmt", stop_after_first = true },
        typescript = { "prettier", "biome", "oxfmt", stop_after_first = true },
        typescriptreact = { "prettier", "biome", "oxfmt", stop_after_first = true },
        json = { "biome", "prettier", stop_after_first = true },
        jsonc = { "biome", "prettier", stop_after_first = true },
        css = { "biome", "prettier", stop_after_first = true },
        html = { "biome", "prettier", stop_after_first = true },
    },
    formatters = {
        prettier = {
            condition = function(_, ctx)
                return vim.fs.find({
                    ".prettierrc",
                    ".prettierrc.json",
                    ".prettierrc.yml",
                    ".prettierrc.yaml",
                    ".prettierrc.js",
                    ".prettierrc.mjs",
                    ".prettierrc.cjs",
                    "prettier.config.js",
                    "prettier.config.mjs",
                    "prettier.config.cjs",
                }, { path = ctx.filename, upward = true })[1] ~= nil
            end,
        },
        biome = {
            condition = function(_, ctx)
                return vim.fs.find(
                    { "biome.json", "biome.jsonc" },
                    { path = ctx.filename, upward = true }
                )[1] ~= nil
            end,
        },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format local buffer" })
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Format local buffer" })

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.enable({
    'lua_ls',
    'clangd',
    'ts_ls',
    'oxlint',
})
