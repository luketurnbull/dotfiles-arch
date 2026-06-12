# AGENTS.md

This is a **chezmoi dotfiles repository** for Arch Linux (`luketurnbull/dotfiles-arch`).
The `dot_` prefix maps to `.` in the home directory (e.g., `dot_zshrc` → `~/.zshrc`).

## Quick reference

| What | Where | How to modify |
|---|---|---|
| Shell | `dot_zshrc` | Edit and `chezmoi apply` |
| Neovim | `dot_config/nvim/` | Config in `init.lua`, splits in `lua/`, LSP in `lsp/` |
| Hyprland | `dot_config/hypr/` | Lua-based DSL; `appearance.lua`, `monitors.lua`, `hyprland.lua` |
| Ghostty | `dot_config/ghostty/config.ghostty` | Terminal theme and padding |
| System packages | `.chezmoidata/packages.yaml` | chezmoi template data |
| Package installer | `run_onchange_install-packages.sh.tmpl` | chezmoi run_onchange script |

## Key commands

```bash
chezmoi apply          # apply pending changes
chezmoi diff           # review changes before applying
chezmoi status         # see what has changed
chezmoi add ~/.zshrc   # add a new file to management
chezmoi cd             # cd into the source directory
```

## chezmoi behavior

- **Auto-commit** is enabled (`chezmoi.toml`: `autoCommit=true`). Each `chezmoi apply` creates a git commit automatically.
- The repo branch is `master` (not `main`).
- No `.gitignore` exists — everything is tracked.
- Template variables are in `.chezmoidata/packages.yaml`.

## Architecture notes

- **Neovim** uses the v0.11+ `vim.pack.add` API (no lazy.nvim or packer). Packages: tokyonight, blink.cmp, friendly-snippets, conform.nvim. Formatter: `stylua` (invoked via conform on save). LSP: `lua-language-server` via `vim.lsp.enable()`.
- **Hyprland** uses the Lua-based config DSL (`hl.*` functions). See `/usr/share/hypr/stubs` for LSP stubs. The `hyprpaper` daemon loads `~/.config/hypr/wallpapers/big.jpg`.
- **Ghostty** terminal: TokyoNight Night theme, block cursor, zsh shell integration.
- **Package management**: packages defined in `.chezmoidata/packages.yaml` as chezmoi template data; installed by a `run_onchange` script that calls `pacman -S` and optionally `paru -S` for AUR packages. To add a package, edit `packages.yaml` and run `chezmoi apply`.

## Sensitive

- `dot_zshrc` contains a `CONTEXT7_API_KEY` — avoid committing this value separately; it is already in the file.

## What is NOT here

- No CI, no tests, no build system, no task runner.
- No README — the files are the documentation.
