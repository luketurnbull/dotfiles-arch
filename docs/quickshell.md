# Quickshell

Status bar in QML: `dot_config/quickshell/` → `~/.config/quickshell/`.

## Layout

Top bar with pill-shaped widgets on a transparent background. The window height is driven by the visible bar content.

| File | Role |
|---|---|
| `shell.qml` | Root: `Scope` instantiating `Bar` |
| `Bar.qml` | One `PanelWindow` per screen: strip layout (workspaces, clock, battery) |
| `Workspaces.qml` | Workspace pills (`Row` + `Repeater` over `Hyprland.workspaces`) |
| `ClockWidget.qml` | `StyledText` showing `Time.time` |
| `BatteryWidget.qml` | `StyledText` showing a Nerd Font battery glyph |
| `StyledText.qml` | Shared `Text` base: bold, uppercase, `Theme.text`, `Appearance.fontSize` |
| `Theme.qml` | `pragma Singleton`: color palette from `palette.json` |
| `Appearance.qml` | `pragma Singleton`: theme-independent sizing and animation curves/durations |
| `Time.qml` | `pragma Singleton`: `SystemClock` with `Minutes` precision |

Left: workspaces. Center: clock pill. Right: battery pill.

## Styling

- Pills: `Rectangle` with `radius: height / 2` (fully circular), 20px horizontal / 8px vertical padding; top corners square (hug the screen edge).
- Window margins from `Appearance.barMargin` (mirrors hyprland `gaps_out`), so pills float off the screen edges.
- Workspace pills dimmed (opacity 0.6) unless active.
- All text is `StyledText`: bold, uppercase, `Appearance.fontSize` (11).
- Colors from the `Theme` singleton (reads `~/.config/themes/current/palette.json`); sizes/curves from the `Appearance` singleton. Components read both directly — no prop-passing.

## Battery logic

- `percentage` is a plain property bound to `UPower.displayDevice.percentage` (0–1), event-driven over DBus, no polling.
- Pill shows a Nerd Font glyph picked from a 10-step array (`floor(percentage * 10)`, clamped to 9). `charging` (from `UPowerDevice.state`) swaps to the charging glyph set. Glyphs turn `Theme.warn` red below 15%.

## Gotchas

- Battery glyph codepoints in the `F089x` block are **non-contiguous** — the charging set interleaves it (10/50/70 → `F089C/D/E`, rest in `F008x`). Both arrays are hardcoded 10-entry tables (index = `floor(pct × 10)` clamped to 9); dropping an entry shows "UNDEFINED" (thanks to `Font.AllUppercase`).
- If the battery shows as tofu/blank, Qt6 font fallback didn't kick in (QTBUG-110502) — add `font.family: "Symbols Nerd Font"` to `BatteryWidget.qml` (confirm the exact family with `fc-list | grep -i symbols`).
- Files with `pragma Singleton` using the `Singleton` base type still need `import Quickshell` — a missing import surfaces as `Singleton is not a type` with a misleading cascade of "Type X unavailable" errors through every other singleton.
- **chezmoi v2 `apply` never deletes targets** whose source files were removed — `rm` them in `~/` by hand (and unmanaged experiment files are invisible to `chezmoi status` entirely).
- **Multi-file applies race the live-reload**: quickshell can reload mid-apply with "X is not a type" for files written a moment later. Transient — `touch shell.qml` to force a clean reload before believing errors.
