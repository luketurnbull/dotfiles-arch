return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

  -- seamless C-hjkl navigation between nvim splits and tmux panes
  -- eager-loaded: the lazy keys= handler gets clobbered by nvchad.mappings
  -- (which maps C-hjkl to <C-w>hjkl after lazy.setup); mappings.lua then
  -- re-maps over NvChad, so mappings must be created load-order-aware
  { "christoomey/vim-tmux-navigator", lazy = false },
}
