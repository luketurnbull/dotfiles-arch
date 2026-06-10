require("vim._core.ui2").enable({})

require('options')
require('keymaps')
require('pack')

vim.cmd.colorscheme("tokyonight-night")

-- LSP
require("blink.cmp").setup({
  keymap = { preset = "default" },
  apperance = { nerd_font_variable = "mono" },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = { enabled = true },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    ghost_text = { enabled = true },
  },
})

vim.lsp.enable('lua_ls')

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }

    -- navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  end,
})
