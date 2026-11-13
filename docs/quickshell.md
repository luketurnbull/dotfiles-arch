# Quickshell

Status bar in QML: `dot_config/quickshell/` → `~/.config/quickshell/`.

## Layout

Top bar, pill-shaped widgets on a transparent background. Height is content-driven (`Math.max` of the two pill groups), never hardcoded.

| File | Role |
|---|---|
| `shell.qml` | Root: `Scope` + `Variants` over `Quickshell.screens` |
| `Bar.qml` | One `PanelWindow` per screen; all pills declared inline (no shared pill component) |
| `ClockWidget.qml` | `Text` showing `Time.time` (12pt, bold, uppercase) |
| `BatteryWidget.qml` | `Text` showing a Nerd Font battery glyph (12pt) |
| `Time.qml` | `pragma Singleton`: `SystemClock` with `Minutes` precision |

All positioned with `anchors.top: parent.top`. Left: workspaces. Center: clock + battery in one `Row`.

## Styling

- Pills: `Rectangle` with `radius: height / 2` (fully circular), 20px horizontal / 8px vertical padding.
- Window margins 5 all sides (mirroring hyprland `gaps_out`), so pills float off the screen edges.
- Workspace pills dimmed (opacity 0.6) unless active.
- Colors from `Theme.qml` (reads `~/.config/themes/current/palette.json`).

## Battery logic

- `percentage` is a plain property bound to `UPower.displayDevice.percentage` (0–1), event-driven over DBus, no polling.
- Text shows a Nerd Font glyph picked from a 10-step array (`floor(percentage * 10)`, clamped to 9).
- `charging` (from `UPowerDevice.state`) swaps to the charging glyph set.
- Glyphs turn red (`#ff4d42`) below 15%.

## Gotchas

- Battery glyph codepoints in the `F089x` block are **non-contiguous** (0/50/70 are skipped in the charging set) — both arrays are hardcoded, don't do math on them.
- If the battery shows as tofu/blank, Qt6 font fallback didn't kick in (QTBUG-110502) — add `font.family: "Symbols Nerd Font"` to `BatteryWidget.qml` (confirm the exact family with `fc-list | grep -i symbols`).

## Extending

New widget = new `.qml` file, add to the clock/battery `Row` in `Bar.qml` (for center) or a new position in `Bar.qml`. Quickshell auto-reloads on save.
