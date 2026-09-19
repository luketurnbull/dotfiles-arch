# AGENTS.md

Chezmoi dotfiles for Arch Linux (`luketurnbull/dotfiles-arch`), branch `archpad`.
`dot_` prefix maps to `.` in `~/` (`dot_zshrc` → `~/.zshrc`).
Deep detail per topic lives in `docs/` (repo-only, chezmoi-ignored).

## Layout

| What | Where | Docs |
|---|---|---|
| Shell (zsh) | `dot_zshrc` | `docs/shell.md` |
| Starship | `dot_config/starship.toml` | `docs/shell.md` |
| Neovim | `dot_config/nvim/` (NvChad v2.5 + lazy.nvim) | `docs/neovim.md` |
| Hyprland | `dot_config/hypr/` (Lua DSL, `hl.*`) | `docs/hyprland.md` |
| Quickshell | `dot_config/quickshell/` (QML bar) | `docs/quickshell.md` |
| Ghostty | `dot_config/ghostty/` | `docs/ghostty.md` |
| tmux | `dot_config/tmux/tmux.conf` | `docs/tmux.md` |
| bat | `dot_config/bat/` | `docs/shell.md` |
| Zen Browser | `dot_config/zen-chrome/userChrome.css` | `docs/zen-browser.md` |
| opencode | `dot_config/opencode/` | `docs/opencode.md` |
| Packages | `.chezmoidata/packages.yaml` + `run_onchange_install-packages.sh.tmpl` | `docs/packages.md` |
| Host hardware | — | `docs/computer.md` |
| Theming | hardcoded TokyoNight per app | `docs/theming.md` |

## Rules

- Workflow: edit → `chezmoi diff` → `chezmoi apply` → commit manually. No auto-commit, no `chezmoi.toml`, no `.gitignore`.
- `.chezmoiignore`: `AGENTS.md`, `README.md`, `docs/` — repo-only, never applied to `~/`.
- `dot_config/opencode/AGENTS.md` **is** applied (→ `~/.config/opencode/AGENTS.md`, global opencode rules).
- **No secrets in this repo.** context7 key lives at `~/.secrets/context7_api_key`, read via `{file:...}` in `opencode.jsonc`.
- Add a package: edit `packages.yaml`, `chezmoi apply`. AUR via paru, rest via pacman `--needed`.
- No CI, no tests, no build system.

## Keybinds (Hyprland, mainMod = SUPER)

`SUPER+T` ghostty · `SUPER+B` zen · `SUPER+N` obsidian · `SUPER+SHIFT+S` obs · `SUPER+SHIFT+B` blender · `SUPER+W` close · `SUPER+hjkl/arrows` focus · `SUPER+SHIFT+*` move · `SUPER+0-9` workspace · `SUPER+F10/F11/F12` mute/vol · `SUPER+SHIFT+M` exit · `ALT+G` toggle 16:9 recording gaps. tmux prefix is default `C-b`.

## Gotchas

- **NvChad sets mason `PATH = "skip"`** — LSP servers come from pacman/AUR, not Mason; `js-debug-adapter` is referenced by absolute `stdpath/data/mason` path. Never `:MasonInstallAll`.
- **`devices.lua` disables the internal ThinkPad keyboard** — re-enable if no external keyboard.
- **`monitors.lua` is dynamic**: any non-`eDP-1` output = external (scale 1.25 at `0x0`, laptop `auto-down`); lid switch toggles `eDP-1`. `monitor-added.sh` (socat hotplug watcher) exists but is **not wired into autostart** — currently unused.
- **ghostty `command = tmux`** blocks auto shell-integration injection → new tabs/splits open in default cwd, not current. Fix documented in `docs/ghostty.md`.
- **Zen chrome linker script was removed** — `userChrome.css` must be symlinked into each profile manually (steps in `docs/zen-browser.md`).
- `quickshell` autostarts from `hyprland.lua`; bar is a minimal starter (clock + battery). `qmlls6` comes from `qt6-declarative` (quickshell dep).
