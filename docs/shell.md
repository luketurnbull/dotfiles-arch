# Shell (zsh + starship + bat)

## zsh (`dot_zshrc` → `~/.zshrc`)

- `EDITOR`/`VISUAL = nvim`; `PATH` prepends `~/bin`, `/usr/local/bin`.
- Man pages: `MANROFFOPT="-c"`, `MANPAGER="sh -c 'col -bx | bat -l man -p'"`.
- History: 50000 entries in `~/.zsh_history`, dedup options (`EXTENDED_HISTORY`, `INC_APPEND_HISTORY`, `SHARE_HISTORY`, `HIST_EXPIRE_DUPS_FIRST`, `HIST_IGNORE_DUPS`/`_ALL_DUPS`/`_SPACE`, `HIST_SAVE_NO_DUPS`, `HIST_REDUCE_BLANKS`).
- Completion: `compinit` with menu select + case-insensitive matching.
- Aliases: `vi → nvim`, `cat → bat`, `lg → lazygit`, `ls → eza --icons=always`.
- Sources: `zsh-autosuggestions`, `zsh-syntax-highlighting` (pacman, `/usr/share/zsh/plugins/`), `nvm/init-nvm.sh`.
- Prompt: `eval "$(starship init zsh)"`.

## Starship (`dot_config/starship.toml`)

- `$schema` for editor validation.
- Directory: `truncation_length = 3`, `truncation_symbol = '../'`.
- Compact `\[[$symbol($version)]($style)\]`-style formats for many modules (bun, c, cmake, cmd_duration `⏱`, container, deno, direnv, git, node, lua, rust, python, …).

## bat (`dot_config/bat/`)

- Used by the `cat` alias and the man pager.
- `config`: `--theme="tokyonight_night"`.
- Custom theme: `themes/tokyonight_night.tmTheme`.
