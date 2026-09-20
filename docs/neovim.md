# Neovim

`dot_config/nvim/` → `~/.config/nvim/`. **NvChad v2.5 + lazy.nvim** on neovim 0.12.

## Structure

- `init.lua` — bootstraps `folke/lazy.nvim` into `stdpath/lazy/lazy.nvim`, runs `lazy.setup` with `NvChad` (branch `v2.5`, imports `nvchad.plugins`) + local `lua/plugins/`. **Not** `vim.pack.add`. `mapleader` = space; base46 cache (`vim.g.base46_cache`) loaded via `dofile` for `defaults` + `statusline`.
- `lua/chadrc.lua` — NvChad UI config; `theme = "tokyonight"`.
- `lua/options.lua` — `relativenumber`.
- `lua/mappings.lua` — visual J/K move lines, `C-d`/`u`/`o`/`i` center cursor, tmux-aware nav re-maps, DAP keys.
- `lua/configs/` — `lazy.lua`, `lspconfig.lua`, `conform.lua`, `dap.lua`.
- `dot_stylua.toml` → `~/.config/nvim/.stylua.toml` — column 120, 2-space indent, double quotes, no call parens.

## Plugins (`lua/plugins/init.lua`)

| Plugin | Notes |
|---|---|
| `stevearc/conform.nvim` | format on save (`BufWritePre`) |
| `neovim/nvim-lspconfig` | → `configs/lspconfig.lua` |
| `mfussenegger/nvim-dap` | + `rcarriga/nvim-dap-ui`, `nvim-neotest/nvim-nio`, `mxsdev/nvim-dap-vscode-js` |
| `christoomey/vim-tmux-navigator` | `lazy = false` — a lazy `keys=` handler gets clobbered by `nvchad.mappings` (maps `C-hjkl` → `<C-w>hjkl` after `lazy.setup`); `mappings.lua` re-maps to `TmuxNavigate*` after `require("nvchad.mappings")` to win last-set-wins |
| `xvzc/chezmoi.nvim` | + `nvim-lua/plenary.nvim`; `edit.watch = false`, ignores `run_onchange_*`/`run_once_*`/`.chezmoiignore`/`.chezmoitemplate`/`AGENTS.md` |

## LSP (`lua/configs/lspconfig.lua`)

`nvchad.configs.lspconfig.defaults()` then `vim.lsp.enable{ "html", "cssls", "clangd", "qmlls", "bashls", "autotools_ls" }`; `qmlls` overridden with `cmd = { "qmlls6" }` (from `qt6-declarative`, a quickshell dep).

**Server binaries come from pacman/AUR, not Mason** — NvChad sets mason `PATH = "skip"`, so Mason-installed binaries are invisible to `vim.lsp.enable`. `bash-language-server` + `shellcheck` (pacman) feed bashls; `autotools-language-server` from AUR. Avoid `:MasonInstallAll` — it scrapes the lspconfig list and would duplicate pacman servers inside Mason.

## Formatting (`lua/configs/conform.lua`)

`stylua` (lua), `clang-format` (c). `format_on_save` timeout 500ms, `lsp_fallback = true`.

## DAP (`lua/configs/dap.lua`)

- **C/C++**: gdb's built-in DAP (`gdb --interpreter=dap`, zero extra install — compile targets with `-g`).
- **JS/TS**: Mason's prebuilt `js-debug-adapter` referenced by **absolute path** (`stdpath/data/mason/bin/js-debug-adapter`, because of the mason `PATH = "skip"` gotcha) via `dap-vscode-js` (`pwa-node`/`pwa-chrome`/`node-terminal`; launch file, attach). Install manually with `:MasonInstall js-debug-adapter`.
- dap-ui auto opens/closes with the session.
- Keys: `F5` continue, `F10`/`F11`/`F12` step over/into/out, `<leader>db` breakpoint, `<leader>du` toggle UI.
