# Ghostty

`dot_config/ghostty/` → `~/.config/ghostty/`. ghostty 1.4.0.

## Config (`config.ghostty`)

| Key | Value |
|---|---|
| `theme` | `static-noir` — custom theme file `themes/static-noir` (16 ANSI colors, bg `#0a0a0a`, fg `#ededed`, cursor `#ff3b30`) |
| `font-size` | `12` (no family set — ghostty default monospace) |
| `background-opacity` | `0.99` — invisible on its own; real translucency comes from Hyprland's `active_opacity`. Exists only to unlock `background-blur` (see caveat) |
| `background-blur` | `true` — opts into the `ext-background-effect-v1` blur region so Hyprland blurs behind the window |
| `window-padding-x` / `-y` | `20` / `15` |
| `window-padding-balance` | `true` — spreads sub-cell leftover pixels across all edges (tiled heights are rarely exact cell multiples; without it the remainder pools at the bottom) |
| `cursor-style` | `block` |
| `shell-integration` | `zsh` |
| `custom-shader` | `~/.config/ghostty/shaders/cursor_blaze.glsl` |
| `command` | `tmux` — every new terminal starts in tmux, one session per window |
| `confirm-close-surface` | `false` |

## Shader

`shaders/cursor_blaze.glsl` — custom cursor trail effect, loaded via `custom-shader`.

## Caveat: blur needs ghostty opt-in (GTK 4.24 + Hyprland ≥0.56)

Hyprland ≥0.56 honors `ext-background-effect-v1`: if a surface has a background-effect object, Hyprland blurs only the client-set blur region. GTK 4.24 creates that object with an **empty** region on every toplevel unless the app asks (GNOME/gtk#8344, omarchy#15924), which silently disables compositor blur behind all GTK4 windows. Ghostty ≥1.4 sets the region itself, but only when `background-blur` is set **and** `background-opacity < 1` — hence the `0.99` + `true` pair. Non-GTK terminals (kitty/foot) are unaffected. If blur vanishes again after a ghostty/GTK upgrade, check these two keys first.

## Caveat: shell integration + `command = tmux`

With `command = tmux`, ghostty injects shell integration into the launched process — which is tmux, not zsh — so integration is lost: **new tabs/splits open in the default cwd instead of the current one**. Fix if it matters: source the integration manually in `dot_zshrc`:

```zsh
source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
```

## Relationship with tmux

Ghostty owns window management (GUI tabs/splits); tmux is an invisible scrollback/copy-mode layer inside each window. Sessions persist on the tmux server after a window closes — occasionally `tmux kill-server` to sweep strays. See `tmux.md`.
