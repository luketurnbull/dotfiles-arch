# Theming

Omarchy-style switchable themes. Registry in `dot_config/themes/<name>/` (chezmoi-managed); the **active** theme is copied to `~/.config/themes/current/` by `theme-set` (script-owned, never in the repo — chezmoi would revert it on apply).

Ships: `noir` (the old static-noir, preserved), `tokyo-night`, `gruvbox`, `adventure`, `after-hours`, `aurora-drift`.

## Theme dir layout

Each theme dir holds a canonical palette + per-app files derived from it:

| File | Used by | Content |
|---|---|---|
| `colors.toml` | reference / future gen scripts | canonical palette: `background`, `foreground`, `cursor*`, `selection_*`, `accent`, `warn`, `dim`, `color0`–`color15` |
| `ghostty` | ghostty | raw palette keys — **not** `theme = name` (file is pulled in via `config-file`; raw keys keep non-builtin themes possible) |
| `nvim` | NvChad | base46 theme name only (`tokyonight`, `gruvbox`, or a custom file in `nvim/lua/themes/`) |
| `tmux.conf` | tmux | `pane-border-style`, `pane-active-border-style`, `mode-style`, `message-style` |
| `hyprland.lua` | Hyprland | returns `{ active = "rgb(...)", inactive = "rgb(...)" }` |
| `palette.json` | quickshell | `{ bg, bgSolid, text, accent, warn }` — `bg` carries the `ee` alpha prefix |

## Hookups (chezmoi-managed side)

| App | Mechanism |
|---|---|
| Ghostty | `config-file = ?../themes/current/ghostty` in `config.ghostty` (`?` = optional, relative to the config file) |
| NvChad | `chadrc.lua` reads `current/nvim` at startup, fallback `static_noir`; custom themes in `lua/themes/` |
| tmux | `source-file -q ~/.config/themes/current/tmux.conf` |
| Hyprland | `appearance.lua`: `pcall(dofile, …/current/hyprland.lua)`, fallback noir values |
| Quickshell | `Theme.qml`: `FileView` on `current/palette.json` with `watchChanges` |
| bat | **nothing** — `--theme="ansi"` follows the terminal palette for free |

## `theme-set` (`~/bin/theme-set`)

Usage: `theme-set [name]` (fzf picker, `select` fallback) · `theme-set list` · `theme-set current`

1. Copy-swaps `themes/<name>` → `themes/current` — real files, not symlinks (file watchers need new inodes)
2. Writes the name to `~/.local/state/theme/current`
3. Reloads: `pkill -SIGUSR2 ghostty` (official reload signal), `hyprctl reload`, `tmux source-file`
4. Restarts quickshell via `setsid` (`hyprctl dispatch exec` is broken by the hypr Lua DSL)
5. Rebuilds the base46 highlight cache headlessly (the `docs/neovim.md` gotcha, automated)
6. Live-switches **running** nvim instances via their server sockets (`/run/user/$UID/nvim.*.*`) — same recipe as NvChad's own theme picker (`nvconfig.base46.theme = …` + `load_all_highlights` + volt reload). Omarchy doesn't do this; we do.

## Adding a theme

1. `mkdir dot_config/themes/<name>/` and write `colors.toml` first
2. Derive the per-app files from it. Ghostty builtin palettes to copy: `/usr/share/ghostty/themes/` (browse with `ghostty +list-themes`); Omarchy palettes live in `omarchy/themes/<name>/colors.toml`
3. If no base46 theme matches, add `dot_config/nvim/lua/themes/<name>.lua` (copy `after_hours.lua` as a template) and put the name in the theme's `nvim` file
4. `chezmoi diff` → `chezmoi apply` → `theme-set <name>`

## Not switched (still static / pinned)

- **opencode** — `tui.json` + `themes/static-noir.json`; theme selection would fight chezmoi. Parked.
- **lazygit** — custom noir `gui.theme`. Parked.
- **Helium browser** — no file/CLI theming exists (color picker is manual, Web Store themes broken). Parked.
