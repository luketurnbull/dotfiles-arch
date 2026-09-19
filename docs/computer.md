# Computer

Host: **ThinkPad T490s** (`20NYS2LT01`), hostname `archpad`, Arch Linux x86_64, locale `en_AU.UTF-8`.

## Hardware

- **CPU**: Intel Core i7-8665U, 8 logical cores @ 4.80 GHz
- **GPU**: Intel UHD Graphics 620 (integrated) @ 1.15 GHz
- **RAM**: 15.40 GiB, no swap
- **Disk**: 116.24 GiB ext4 on `/`
- **Battery**: 02DL013

## Displays

| Output | Panel | Mode | Scale |
|---|---|---|---|
| `eDP-1` | internal `CMN14F5` 14" | 1920x1080@60 | 1.25 |
| `DP-2` | Xiaomi Mi Monitor 34" ultrawide | 3440x1440@50 | 1.25 |

Monitor assignment is dynamic — see `hyprland.md`. Output names are discovered at runtime (`hl.get_monitors()`), not hardcoded.

## Software versions

Snapshot 2026-09-19 (`pacman -Q`); the kernel in particular drifts with every update.

- kernel `7.2.6-arch2-1`
- Hyprland `0.56.2` (Wayland) · quickshell `0.3.1` · hyprpaper
- ghostty `1.3.1` · tmux `3.7c` · zsh `5.9.2` · starship `1.26.0`
- neovim `0.12.5`
- qt6-declarative `6.11.2` (provides `qmlls6`)
- Cursor: default, 24px. Terminal font: ghostty default monospace @ 12pt (no family set in config).
- Notifications: swaync · OSD: swayosd

## Notes

- Internal keyboard (`at-translated-set-2-keyboard`) is **disabled** in `dot_config/hypr/devices.lua` — an external keyboard is used.
- ~876 pacman packages installed; managed list in `.chezmoidata/packages.yaml`.
