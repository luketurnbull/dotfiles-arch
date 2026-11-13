# Ghostty

`dot_config/ghostty/` → `~/.config/ghostty/`. ghostty 1.4.0.

## Config (`config.ghostty`)

| Key | Value |
|---|---|
| `config-file` | `?../themes/current/ghostty` — active theme, written by `theme-set` (raw palette keys per theme dir; see `docs/theming.md`) |
| `font-size` | `12` (no family set — ghostty default monospace) |
| `background-opacity` | `0.99` — invisible on its own; real translucency comes from Hyprland's `active_opacity`. Exists only to unlock `background-blur` (see caveat) |
| `background-blur` | `true` — opts into the `ext-background-effect-v1` blur region so Hyprland blurs behind the window |
| `window-padding-x` / `-y` | `20` / `15` |
| `window-padding-balance` | `true` — spreads sub-cell leftover pixels across all edges (tiled heights are rarely exact cell multiples; without it the remainder pools at the bottom) |
| `cursor-style` | `block` |
| `cursor-style-blink` | `false` — a blinking block cursor forces a redraw of every terminal window at ~1Hz forever; off to stop constant renderer CPU on battery |
| `shell-integration` | `zsh` |
| `custom-shader` | `~/.config/ghostty/shaders/cursor_blaze.glsl` |
| `confirm-close-surface` | `false` |

## Shader

`shaders/cursor_blaze.glsl` — custom cursor trail effect, loaded via `custom-shader`.

## Caveat: blur needs ghostty opt-in (GTK 4.24 + Hyprland ≥0.56)

Hyprland ≥0.56 honors `ext-background-effect-v1`: if a surface has a background-effect object, Hyprland blurs only the client-set blur region. GTK 4.24 creates that object with an **empty** region on every toplevel unless the app asks (GNOME/gtk#8344, omarchy#15924), which silently disables compositor blur behind all GTK4 windows. Ghostty ≥1.4 sets the region itself, but only when `background-blur` is set **and** `background-opacity < 1` — hence the `0.99` + `true` pair. Non-GTK terminals (kitty/foot) are unaffected. If blur vanishes again after a ghostty/GTK upgrade, check these two keys first.

## Resolved: shell integration + `command = tmux`

ghostty used to start every window in tmux (`command = tmux`), which ate the shell-integration injection (new tabs/splits opened in the default cwd). Auto-tmux was dropped, so integration now injects normally and cwd is inherited. If tmux is ever re-added as `command`, the manual fix is sourcing `$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration` in `dot_zshrc`.

## Relationship with tmux

tmux is opt-in (run `tmux` yourself), not auto-started per window. Note: tmux sessions persist on the server after a window closes *and* detached sessions keep their apps alive invisibly (an orphaned nvim sat at ~0.9% CPU for hours) — sweep strays with `tmux kill-server`, or kill only detached ones: `tmux list-sessions -F '#{session_name} #{session_attached}' | awk '$2==0 {print $1}' | xargs -r -n1 tmux kill-session -t`. See `tmux.md`.
