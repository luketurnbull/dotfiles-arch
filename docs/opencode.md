# opencode

`dot_config/opencode/` → `~/.config/opencode/` — global config, applied to every project.

## Files

| File | Purpose |
|---|---|
| `opencode.jsonc` | Main config |
| `tui.json` | `"theme": "tokyonight"` |
| `AGENTS.md` | Global agent rules (communication style, context7 usage) — applied to `~/.config/opencode/AGENTS.md`, **not** chezmoi-ignored |

## opencode.jsonc

- `default_agent = tutor`.
- Agents `build` / `plan` / `general` all enabled.
- context7 MCP: remote `https://mcp.context7.com/mcp`, header `CONTEXT7_API_KEY` read from `~/.secrets/context7_api_key` via `{file:...}`.

## Secrets

**No secret is committed to this repo.** The context7 key lives outside the repo at `~/.secrets/context7_api_key`. Keep it there — never move it into a tracked file.
