# Ghostty

`dot_config/ghostty/` → `~/.config/ghostty/`. ghostty 1.3.1.

## Config (`config.ghostty`)

| Key | Value |
|---|---|
| `theme` | `TokyoNight Night` |
| `font-size` | `12` (no family set — ghostty default monospace) |
| `window-padding-x` / `-y` | `15` / `0` |
| `window-padding-color` | `extend-always` |
| `window-padding-balance` | `true` — spreads sub-cell leftover pixels across all edges (tiled heights are rarely exact cell multiples; without it the remainder pools at the bottom) |
| `cursor-style` | `block` |
| `shell-integration` | `zsh` |
| `custom-shader` | `~/.config/ghostty/shaders/cursor_blaze.glsl` |
| `command` | `tmux` — every new terminal starts in tmux, one session per window |
| `confirm-close-surface` | `false` |

## Shader

`shaders/cursor_blaze.glsl` — custom cursor trail effect, loaded via `custom-shader`.

## Caveat: shell integration + `command = tmux`

With `command = tmux`, ghostty injects shell integration into the launched process — which is tmux, not zsh — so integration is lost: **new tabs/splits open in the default cwd instead of the current one**. Fix if it matters: source the integration manually in `dot_zshrc`:

```zsh
source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
```

## Relationship with tmux

Ghostty owns window management (GUI tabs/splits); tmux is an invisible scrollback/copy-mode layer inside each window. Sessions persist on the tmux server after a window closes — occasionally `tmux kill-server` to sweep strays. See `tmux.md`.
