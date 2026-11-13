# Quickshell

Status bar in QML: `dot_config/quickshell/` → `~/.config/quickshell/`. quickshell `0.3.2`, autostarted by `hyprland.lua` (`hl.exec_cmd("quickshell")`). Top bar: battery top-left, clock centered, Hyprland workspaces top-right.

## Files

| File | Role |
|---|---|
| `shell.qml` | Root `Scope` → `Bar {}` |
| `Bar.qml` | One `PanelWindow` per screen (`Variants` over `Quickshell.screens`), anchored top/left/right, `implicitHeight: 30`, transparent. Battery pill left, `ClockWidget` centered (`anchors.centerIn` — exact center regardless of unbalanced sides), `Row` + `Repeater` over `Hyprland.workspaces` right |
| `Pill.qml` | Generic pill: `Rectangle` + centered bold 10pt uppercase `Text`. Props: `text` (required), `textColor`, `horizontalPadding`, `verticalPadding`. `radius: 999` with `topLeftRadius`/`topRightRadius: 0` (Qt ≥6.7 per-corner radii) → flat top flush with screen edge, rounded bottom |
| `ClockWidget.qml` | `Pill` bound to `Time.time` |
| `Time.qml` | `pragma Singleton`: `SystemClock` formatted `hh:mm`. Uses `SystemClock.Minutes` precision — seconds aren't displayed, and the quickshell docs note Minutes improves battery life (fewer wake-ups/repaints) |
| `BatteryWidget.qml` | `Pill` bound to battery % from `Quickshell.Services.UPower` |
| `Theme.qml` | Active-theme palette loader: `FileView` on `~/.config/themes/current/palette.json` (`watchChanges`, noir defaults) exposing `bg`/`bgSolid`/`text`/`accent`/`warn` |

## Styling

All pills share `Pill.qml`. Margins are 0 → pills hang from the very top of the screen. Workspace pills are dimmed unless `active`. Colours come from `Theme.qml` (see table) — `theme-set` restarts the bar on switch since the swap replaces the whole `current/` dir.

`ExclusionMode.Auto` (default with 3 anchors) reserves 30px above windows; set `exclusiveZone: 0` in `Bar.qml` if the bar should float over windows instead.

## Battery logic

- `percentage` is a plain property binding to `UPower.displayDevice.percentage` (0–1, rendered as `%`) — event-driven over DBus, no polling. (A redundant `Connections` handler used to overwrite it, breaking the binding on first fire; removed.)
- Text turns red (`#ff4d42`) below 15%, white otherwise.

## Dependencies

- `upower` — battery data (in `packages.yaml`).
- `qt6-declarative` — pulled in as a quickshell dependency; provides **`qmlls6`**, the QML language server used by Neovim (`vim.lsp.enable` list includes `qmlls` with `cmd = { "qmlls6" }`). See `neovim.md`.

## Extending

New widget = new `.qml` file wrapping `Pill`, referenced from `Bar.qml` (auto-reloads on save when quickshell is running). The bar window is a plain `PanelWindow` — add a `TrayWidget`, `MediaWidget`, etc. as siblings of `ClockWidget`.
