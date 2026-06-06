require("vim._core.ui2").enable({})

require('options')

-- Search
vim.o.ignorecase = true -- Ignore the case when searching...
vim.o.smartcase = true -- ...unless the query specifically has an uppercase letter

-- Tabs and spaces
vim.o.expandtab = true -- Tabs become spaces
vim.o.shiftwidth = 2 -- Indent width
vim.o.tabstop = 2 -- Tab renders as 2 spaces
vim.o.signcolumn = "yes" -- Always show the sign column
vim.o.scrolloff = 8 -- Keep 8 lines of context above/below the cursor
vim.o.termguicolors = true -- 24-bit colour (Needed by modern terminals)

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

