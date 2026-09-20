# Package management

Two parts: data (`.chezmoidata/packages.yaml`) + installer (`run_onchange_install-packages.sh.tmpl`).

## packages.yaml

```yaml
packages:
  arch:
    pacman: [ghostty, zsh, ..., hyprland, quickshell, ...]  # official repos
    aur: [opencode, zen-browser-bin, shurectl, autotools-language-server]
```

Groups: terminal tools, code/dev, OS (Wayland stack), programs.

## Installer

`run_onchange_` — re-runs whenever the rendered content changes (i.e. when `packages.yaml` is edited and applied):

1. `sudo pacman -S --needed --noconfirm <pacman list>` — skips already-installed.
2. For each AUR package: `paru -S --noconfirm <pkg>` only if `pacman -Q` says it's missing.

## Add a package

Edit `packages.yaml` → `chezmoi apply`. That's it.

## Notes

- `quickshell` is in the pacman list; its dependency `qt6-declarative` provides `qmlls6` (QML LSP for Neovim).
- `upower` provides battery data for the quickshell `BatteryWidget`.
- `socat` is used by `hypr/monitor-added.sh` (currently unused — see `hyprland.md`).
- LSP servers (`bash-language-server`, `autotools-language-server`) come from here, **not** Mason — see `neovim.md`.
- AUR packages need `paru` installed manually first (it's the bootstrap exception).
