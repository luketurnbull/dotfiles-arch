vim.g.netrw_banner = 0

-- Line numbers
vim.o.number = true -- absolute line number on the current line
vim.o.relativenumber = true -- relative file numbers so it's easier to jump around

-- Search
vim.o.ignorecase = true -- Ignore the case when searching...
vim.o.smartcase = true -- ...unless the query specifically has an uppercase letter

-- Tabs and spaces
vim.o.expandtab = true -- Tabs become spaces
vim.o.shiftwidth = 4 -- Indent width
vim.o.tabstop = 4 -- Tab renders as 2 spaces
vim.o.signcolumn = "yes" -- Always show the sign column
vim.o.scrolloff = 8 -- Keep 8 lines of context above/below the cursor
vim.o.termguicolors = true -- 24-bit colour (Needed by modern terminals)

vim.o.inccommand = "split"

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.o.undofile = true

vim.opt.clipboard:append("unnamedplus") -- Use system clipboard by default
vim.opt.isfname:append("@-@")
-- vim.o.guicursor = ""
vim.o.scrolloff = 8

vim.o.colorcolumn = "0"
vim.o.signcolumn = "yes"
vim.o.cmdheight = 0

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.hl.on_yank()
  end,
})

