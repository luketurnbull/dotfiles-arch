# Theming

**Static Noir**, hardcoded per app — no central theme data on this branch. (A `.chezmoidata/themes.yaml` + templated configs exist in an unmerged commit on another branch; theme switching via scripts is still a future idea.)

Ported from [`dotfiles_macbook`](https://github.com/luketurnbull/dotfiles_macbook) (Nov 2026). The custom theme files — `ghostty/themes/static-noir`, `nvim/lua/themes/static_noir.lua`, `opencode/themes/static-noir.json`, the lazygit `gui.theme` block — are verbatim copies, so both machines stay in sync.

## Per-app values

| App | Where | Value |
|---|---|---|
| Ghostty | `config.ghostty` + `themes/static-noir` | `theme = static-noir` (custom theme file; no opacity/blur — Hyprland handles that per window) |
| NvChad | `lua/chadrc.lua` + `lua/themes/static_noir.lua` | `theme = "static_noir"` + `transparency = true` (Hyprland window opacity shows through) |
| lazygit | `lazygit/config.yml` | custom noir `gui.theme` (accent `#ff3b30`); delta pager + `bat --theme=ansi` preview |
| bat | `config` | `--theme="ansi"` — follows the terminal (ghostty static-noir) palette |
| Hyprland | `appearance.lua` | active border gradient `rgb(666666)` → `rgb(ff3b30)` @45°, inactive `rgb(333333)` |
| Quickshell | `Bar`/`Clock`/`BatteryWidget.qml` | pill bg `#ee0a0a0a`, text `#ededed` (red `#ff4d42` on low battery) |
| tmux | `tmux.conf` | transient only: `mode-style` `bg=#333333,fg=#ededed`, `message-style` `bg=#ff3b30,fg=#0a0a0a`; pane borders `fg=#333333` (active `#ff3b30`) |
| opencode | `tui.json` + `themes/static-noir.json` | `"theme": "static-noir"` (custom theme file) |
| Zen | `userChrome.css` | `--zen-*` vars overridden from a `--tg-*` palette (static noir values) |

## Palette in use

| Hex | Role |
|---|---|
| `#0a0a0a` | background |
| `#050505` | background (darkest, nvim) |
| `#101010` | background (panel) |
| `#191919` | element bg |
| `#ee0a0a0a` | `#0a0a0a` @ ~93% opacity — quickshell pills |
| `#232323` / `#2d2d2d` | bg greys (nvim) |
| `#333333` | selection / borders |
| `#666666` | muted dark (hypr gradient start) |
| `#7d7d7d` / `#929292` | comment / muted |
| `#c9c9c9` | foreground dim |
| `#ededed` | foreground |
| `#ff3b30` | accent red — cursor, active borders |
| `#ff4d42` / `#ff6e64` | red / red bright (errors, low battery) |
| `#9fd08a` / `#b7e2a3` | green / green bright |
| `#e6c15c` / `#f2d47c` | yellow |
| `#7fb2e8` / `#9dc7f2` | blue accent |
| `#d093d0` / `#e0aede` | violet |
| `#74cfd1` / `#93e1e2` | teal |
| `#f3874f` | orange |

To change the theme: touch every row in the first table. There is no single source of truth — yet.
