# Theming

TokyoNight, **hardcoded per app** — no central theme data on this branch. (A `.chezmoidata/themes.yaml` + templated configs exist in an unmerged commit on another branch; theme switching via scripts is still a future idea.)

## Per-app values

| App | Where | Value |
|---|---|---|
| Ghostty | `config.ghostty` | `theme = TokyoNight Night` |
| NvChad | `lua/chadrc.lua` | `theme = "tokyonight"` |
| bat | `config` | `--theme="tokyonight_night"` + custom `themes/tokyonight_night.tmTheme` |
| Hyprland | `appearance.lua` | active border gradient `rgb(3b4261)` → `rgb(7aa2f7)` @45°, inactive `rgb(1a1b26)` |
| Quickshell | `Bar`/`Clock`/`BatteryWidget.qml` | pill bg `#ee1a1b26`, text `#ffffff` (red `#ff0000` on low battery) |
| tmux | `tmux.conf` | transient only: `mode-style` `bg=#3b4261,fg=#c0caf5`, `message-style` `bg=#7aa2f7,fg=#1a1b26`; pane borders `fg=#3b4261` |
| opencode | `tui.json` | `"theme": "tokyonight"` |
| Zen | `userChrome.css` | `--zen-*` vars overridden from a `--tg-*` palette |

## Palette in use

| Hex | Role |
|---|---|
| `#1a1b26` | background |
| `#16161e` | background (dark/panel) |
| `#ee1a1b26` | `#1a1b26` @ ~93% opacity — quickshell pills |
| `#292e42` | highlight |
| `#3b4261` | borders / selection bg (tmux, hypr gradient start) |
| `#414868` | border (zen) |
| `#565f89` | comment |
| `#c0caf5` | foreground |
| `#a9b1d6` | foreground dim |
| `#7aa2f7` | blue accent |

To change the theme: touch every row in the first table. There is no single source of truth — yet.
