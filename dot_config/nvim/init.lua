require("vim._core.ui2").enable({})

require('options')
require('keymaps')

-- Packages
-- Tokyo Night theme, add it as a package and set it
vim.pack.add({ "https://github.com/folke/tokyonight.nvim"}) -- Add package
vim.cmd.colorscheme("tokyonight-night") -- Set as colour scheme

-- LSP
-- Lua LSP
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.git' },
  settings = {
    Lua = { diagnostics = { globals = { 'vim' }}},
  },
})
vim.lsp.enable('lua_ls')

