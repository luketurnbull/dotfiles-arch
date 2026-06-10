require("vim._core.ui2").enable({})

require('options')
require('keymaps')
require('pack')

vim.cmd.colorscheme("tokyonight-night")

-- LSP
vim.lsp.enable('lua_ls')

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = { buffer = args.buf }

    -- navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    -- intellisense: autocomplete as you type (native, no plugin)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

-- popup behaviour: show menu even for one match, don't auto-insert, fuzzy match
vim.o.completeopt = 'menu,menuone,noinsert,fuzzy'
