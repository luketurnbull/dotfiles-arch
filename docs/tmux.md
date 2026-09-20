# tmux

`dot_config/tmux/tmux.conf` → `~/.config/tmux/tmux.conf`. tmux 3.7c.
**Zen setup**: chrome-free, an invisible scrollback/copy-mode layer inside ghostty. Prefix is default `C-b`.

## Chrome

- `status off` — no status line. `prefix t` toggles it for a peek (session-scoped).
- Pane borders: `pane-border-style` and `pane-active-border-style` both `fg=#3b4261`.
- Only TokyoNight left: transient `mode-style` (`bg=#3b4261,fg=#c0caf5`, copy-mode selection) + `message-style` (`bg=#7aa2f7,fg=#1a1b26`, command prompt) — invisible unless in use.
- Note: the file's header comment still mentions `pane-border-lines spaces`/`pane-border-indicators arrows`, but neither option is currently set.

## Base

`default-terminal tmux-256color` + `terminal-overrides ",xterm-ghostty:RGB"` (truecolor in nvim inside tmux), `escape-time 10`, `history-limit 50000`, `focus-events on` (nvim autoread), `mouse off`.

## Vi copy mode

| Key | Action |
|---|---|
| `v` | begin selection |
| `y` | copy to tmux buffer + system clipboard (`wl-copy`) |
| `Escape` | cancel |
| `C-v` | rectangle toggle |
| `prefix r` | incremental search up through scrollback (replaces default refresh-client) |

## Splits & navigation

- `prefix v` — side-by-side split (`split-window -h`, like vim `:vsplit`).
- Bare `C-hjkl` / `C-\` — vim-aware pane navigation (vim-tmux-navigator `is_vim` ps-detection): passes through to nvim at split edges, tmux hands off to nvim panes. Same keys bound in copy-mode.
- `prefix C-l` — clear-screen fallback (bare `C-l` is navigation now).
