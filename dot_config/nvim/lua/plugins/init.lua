return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		opts = require("configs.conform"),
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},

	-- kill the left padding inside nvim-tree (ghostty already adds window padding):
	-- signcolumn "yes" costs 2 columns of textoff, and files at depth 0 get a
	-- 2-space prefix to stay aligned with folder arrows — disable both
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			view = { signcolumn = "no" },
			renderer = {
				indent_markers = { enable = false },
				icons = { show = { folder_arrow = false } },
			},
		},
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			require("configs.dap")
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

	{
		"xvzc/chezmoi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("chezmoi").setup({
				edit = {
					watch = false,
					force = false,
					ignore_patterns = {
						"run_onchange_.*",
						"run_once_.*",
						"%.chezmoiignore",
						"%.chezmoitemplate",
						"AGENTS.md",
					},
				},
			})
		end,
	},
}
