# dotfiles-arch

Chezmoi-managed dotfiles for Arch Linux + Hyprland on a ThinkPad T490s.

| | |
|---|---|
| WM | Hyprland 0.56 (Lua DSL config) |
| Bar | Quickshell 0.3 (QML — clock + battery) |
| Terminal | Ghostty 1.3 + tmux (per-window sessions) |
| Shell | zsh + starship |
| Editor | Neovim 0.12 (NvChad v2.5) |
| Browser | Zen (TokyoNight `userChrome.css`) |
| Theme | TokyoNight, hardcoded per app |

## Quickstart

```bash
sudo pacman -S chezmoi git
chezmoi init --apply https://github.com/luketurnbull/dotfiles-arch.git
```

Uses branch `archpad`. Packages from `.chezmoidata/packages.yaml` install automatically via a `run_onchange_` script (pacman + paru for AUR).

Daily workflow:

```bash
chezmoi edit ~/.zshrc   # or edit files in ~/.local/share/chezmoi directly
chezmoi diff            # review
chezmoi apply           # apply
```

## Structure

```
├── dot_zshrc                  # shell
├── dot_config/
│   ├── hypr/                  # Hyprland (Lua DSL) + hyprpaper + wallpapers
│   ├── quickshell/            # QML status bar
│   ├── ghostty/               # terminal config + cursor shader
│   ├── tmux/                  # tmux.conf (chrome-free scrollback layer)
│   ├── nvim/                  # NvChad v2.5 config
│   ├── starship.toml          # prompt
│   ├── bat/                   # cat replacement + TokyoNight theme
│   ├── opencode/              # AI agent config (global rules, context7 MCP)
│   └── zen-chrome/            # userChrome.css for Zen Browser
├── .chezmoidata/packages.yaml # pacman + AUR package lists
└── run_onchange_install-packages.sh.tmpl
```

## Docs

Detailed notes per component live in [`docs/`](docs/) (not applied to `~/`):

- [computer.md](docs/computer.md) — host hardware & version snapshot
- [hyprland.md](docs/hyprland.md) — Lua config, dynamic monitors, keybinds
- [quickshell.md](docs/quickshell.md) — QML bar widgets
- [neovim.md](docs/neovim.md) — NvChad, LSP, DAP, plugins
- [ghostty.md](docs/ghostty.md) — terminal config & tmux integration
- [tmux.md](docs/tmux.md) — copy mode, pane navigation
- [shell.md](docs/shell.md) — zsh, starship, bat
- [zen-browser.md](docs/zen-browser.md) — chrome theming
- [opencode.md](docs/opencode.md) — AI agent setup
- [packages.md](docs/packages.md) — package management
- [theming.md](docs/theming.md) — TokyoNight values per app
