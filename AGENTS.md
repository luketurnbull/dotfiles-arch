# AGENTS.md

This is a **chezmoi dotfiles repository** for Arch Linux (`luketurnbull/dotfiles-arch`).
The `dot_` prefix maps to `.` in the home directory (e.g., `dot_zshrc` → `~/.zshrc`).

## Host hardware

ThinkPad T490s (`20NYS2LT01`), Arch Linux x86_64, kernel `7.1.8-arch1-3`, locale `en_AU.UTF-8`.
- **CPU**: Intel Core i7-8665U, 8 logical cores @ 4.80 GHz
- **GPU**: Intel UHD Graphics 620 (integrated) @ 1.15 GHz
- **RAM**: 15.40 GiB (no swap)
- **Disk**: 116.24 GiB ext4 on `/`
- **Displays**: internal `CMN14F5` 14" 1920x1080@60, scale 1.25 (`eDP-1`); external `GF340C` 34" 2560x1440@60
- **Stack**: zsh 5.9.2, Hyprland 0.56.2 (Wayland), ghostty 1.3.1, JetBrainsMono Nerd Font 12pt, Adwaita cursor

## Quick reference

| What | Where | How to modify |
|---|---|---|
| Shell | `dot_zshrc` | Edit and `chezmoi apply` |
| Starship prompt | `dot_config/starship.toml` | Edit and `chezmoi apply` |
| Neovim | `dot_config/nvim/` | NvChad v2.5 + lazy.nvim; entry `init.lua`, overrides in `lua/{options,mappings,autocmds,chadrc.lua}`, plugins in `lua/plugins/init.lua`, plugin configs in `lua/configs/` |
| StyLua | `dot_config/nvim/dot_stylua.toml` | Applied as `~/.config/nvim/.stylua.toml` |
| Hyprland | `dot_config/hypr/` | Lua DSL (`hl.*`); `hyprland.lua` (entry), `appearance.lua`, `monitors.lua`, `hyprpaper.conf` |
| Ghostty | `dot_config/ghostty/config.ghostty` | Terminal theme, padding, cursor, shell integration |
| bat | `dot_config/bat/config` + `themes/tokyonight_night.tmTheme` | `cat` alias + `MANPAGER` |
| Zen Browser | `dot_config/zen-chrome/userChrome.css` | TokyoNight via `--zen-*` CSS vars; wired in by `run_onchange_link-zen-chrome.sh.tmpl` |
| opencode | `dot_config/opencode/` | `opencode.jsonc` (agents + context7 MCP), `tui.json` (theme), `AGENTS.md` (global rules) |
| System packages | `.chezmoidata/packages.yaml` | chezmoi template data |
| Package installer | `run_onchange_install-packages.sh.tmpl` | `pacman -S --needed` + `paru -S` for AUR |
| Zen chrome linker | `run_onchange_link-zen-chrome.sh.tmpl` | symlinks `userChrome.css` into each Zen profile |

## Key commands

```bash
chezmoi apply          # apply pending changes
chezmoi diff           # review changes before applying
chezmoi status         # see what has changed
chezmoi add ~/.zshrc   # add a new file to management
chezmoi cd             # cd into the source directory
```

## chezmoi behavior

- No auto-commit — no `chezmoi.toml` exists; commits are made manually after `chezmoi apply`.
- Repo branch is `archpad` (not `main`).
- No `.gitignore` — everything is tracked.
- `.chezmoiignore` lists **root `AGENTS.md`** — this file is repo-only and never applied to `~/`.
- `dot_config/opencode/AGENTS.md` is **not** ignored — it is applied to `~/.config/opencode/AGENTS.md` (the global opencode rules).
- Template data lives in `.chezmoidata/packages.yaml`.

## Theming

TokyoNight is hardcoded per app — no central theme data. Values: Ghostty `config.ghostty` (`theme = TokyoNight Night`), NvChad `lua/chadrc.lua` (`theme = "tokyonight"`), bat `config` (`--theme="tokyonight_night"` + custom tmTheme), Hyprland `appearance.lua` (borders `rgba(7aa2f7ee)` active / `rgba(414868aa)` inactive), opencode `tui.json` (`"theme": "tokyonight"`), Zen `userChrome.css` (`--tg-*` palette). Theme switching via bash scripts is planned.

## Architecture notes

### Neovim (NvChad v2.5 + lazy.nvim)
- **NOT** `vim.pack.add` — `init.lua` bootstraps `folke/lazy.nvim` into `stdpath/lazy/lazy.nvim` and runs `lazy.setup` with `NvChad` (branch `v2.5`, imports `nvchad.plugins`) and the local `plugins` spec.
- base46 cache (`vim.g.base46_cache`) loaded via `dofile` for `defaults` + `statusline`; `mapleader` is space.
- Overrides layered on NvChad: `lua/options.lua` (`relativenumber`), `lua/mappings.lua` (visual J/K move lines, `C-d`/`u`/`o`/`i` center cursor), `lua/autocmds.lua` (passthrough).
- `lua/configs/lazy.lua`: lazy defaults, install colorscheme `nvchad`, performance rtp disabled-plugins list.
- **Plugins** (`lua/plugins/init.lua`): `conform.nvim` (`BufWritePre`), `neovim/nvim-lspconfig`, `mfussenegger/nvim-dap` (loaded on `User FilePost`).
- **LSP** (`lua/configs/lspconfig.lua`): `nvchad.configs.lspconfig.defaults()` then `vim.lsp.enable{ "html", "cssls", "clangd", "qmlls" }`; `qmlls` cmd `qmlls6`.
- **Formatting** (`lua/configs/conform.lua`): `stylua` (lua) and `clang-format` (c); `format_on_save` timeout 500ms, `lsp_fallback = true`.
- **DAP**: `nvim-dap` is declared but not yet configured — see `nvim-dap-setup.md` (repo root) for the pending plan (codelldb install, `lua/configs/dap.lua`, keybinds in `mappings.lua`).
- StyLua config in `dot_config/nvim/dot_stylua.toml` (→ `~/.config/nvim/.stylua.toml`): column 120, 2-space indent, AutoPreferDouble quotes, no call parens.

### Hyprland (Lua DSL)
- Entry `hyprland.lua` requires `appearance` + `monitors`, then defines a clipboard window rule, curves/springs, animations, variables, autostart, and keybinds.
- `.luarc.json` points lua-language-server at `/usr/share/hypr/stubs` for `hl.*` LSP.
- **Variables**: `mainMod = ALT`, `terminal = ghostty`, `browser = zen-browser`.
- **Autostart** (on `hyprland.start`): enable `app-com.mitchellh.ghostty.service` user unit, `hyprpaper`, `quickshell`, `swayosd-server`, `swaync`.
- **Keybinds**: `ALT+T` terminal, `ALT+B` browser, `ALT+S` obs, `ALT+O` obsidian; `ALT+F12`/`F11`/`F10` volume raise/lower/mute; `ALT+W` close; `ALT+hjkl`/arrows focus; `ALT+SHIFT` move; `ALT+0-9` workspaces; `ALT+SHIFT+0-9` move to workspace; `ALT+SHIFT+M` exit.
- **monitors.lua**: `eDP-1` 1920x1080@60 at scale 1.25; `HDMI-A-2` scale 1.
- **appearance.lua**: gaps_in 4 / gaps_out 8, border 1, dwindle layout, hardcoded TokyoNight border colors, opacities 0.99/0.97, blur size 1 passes 2, font `Inter Regular`.
- **hyprpaper.conf**: splash off; `neon-mountain.png` (cover) on `DP-2` and `eDP-1`.

### Ghostty
- `config.ghostty`: `theme = TokyoNight Night`, `window-padding-x = 10` with `window-padding-color = extend-always`, `cursor-style = block`, `shell-integration = zsh`.

### Shell (zsh)
- `dot_zshrc`: `EDITOR`/`VISUAL = nvim`; `MANPAGER` piped through `bat -l man -p`; 50000-entry history with dedup options; `compinit` with menu select + case-insensitive matching; aliases `vi`/`vim → nvim`, `cat → bat`, `lg → lazygit`; sources `zsh-autosuggestions`, `zsh-syntax-highlighting`, `nvm/init-nvm.sh`; `eval "$(starship init zsh)"`.
- Starship (`dot_config/starship.toml`): directory truncation 3; compact `[[...]()` formats for many modules (git, node, lua, c, rust, python, etc.).

### bat
- `cat` alias and man pager use `bat`; `config` sets `--theme="tokyonight_night"`; custom tmTheme at `themes/tokyonight_night.tmTheme`.

### Zen Browser
- `userChrome.css` applies TokyoNight **by overriding Zen's `--zen-*` theme variables** (not per-element backgrounds — the comment explains Zen renders its chrome through a translucent overlay, so element-level `!important` fights it and leaves gaps).
- `run_onchange_link-zen-chrome.sh.tmpl` symlinks `~/.config/zen-chrome/userChrome.css` into each Zen profile's `chrome/` dir (enumerated from `~/.config/zen/profiles.ini`) and sets `toolkit.legacyUserProfileCustomizations.stylesheets = true` in each profile's `user.js`.

### opencode
- `opencode.jsonc`: `default_agent = tutor`; context7 MCP remote at `https://mcp.context7.com/mcp` with `CONTEXT7_API_KEY` read from `~/.secrets/context7_api_key` via `{file:...}`; agents `build`/`plan`/`general` all enabled.
- `tui.json`: `"theme": "tokyonight"`.
- `AGENTS.md`: global opencode rules (read-only, context7 usage, communication style) — applied to `~/.config/opencode/AGENTS.md`.

### Package management
- `packages.yaml` lists `packages.arch.pacman` and `packages.arch.aur`. Installed by `run_onchange_install-packages.sh.tmpl`: `sudo pacman -S --needed --noconfirm` for the pacman list; for each AUR package, `paru -S --noconfirm` if not already installed.
- To add a package: edit `packages.yaml`, `chezmoi apply`.

## Secrets

- **No secret is committed to this repo.** `dot_zshrc` contains no API key.
- The context7 MCP key lives at `~/.secrets/context7_api_key` (outside the repo) and is read by `dot_config/opencode/opencode.jsonc` via `{file:~/.secrets/context7_api_key}`. Do not move the key into a tracked file.

## Known inconsistency

- **External monitor name disagrees across files**: `monitors.lua` configures `HDMI-A-2` while `hyprpaper.conf` targets `DP-2`. fastfetch reports the external panel as `GF340C`. Run `hyprctl monitors` to confirm the live output name and reconcile both files. AGENTS.md documents the mismatch but does **not** fix it — verify before changing.

## What is NOT here

- No CI, no tests, no build system, no task runner.
- No README — the files are the documentation.
- No `.gitignore` — everything under the source dir is tracked.
