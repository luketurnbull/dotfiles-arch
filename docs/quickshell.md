# Quickshell

Status bar in QML: `dot_config/quickshell/` → `~/.config/quickshell/`. quickshell `0.3.2`, autostarted by `hyprland.lua` (`hl.exec_cmd("quickshell")`). Bar: clock + battery + Hyprland workspaces, with a collapsible sidebar width.

## Files

| File | Role |
|---|---|
| `shell.qml` | Root `Scope` → `Bar {}` + `GlobalShortcut` (`toggle-sidebar`, bound via `SUPER+S` `hl.dsp.global` in `keybinds.lua`) |
| `Bar.qml` | One `PanelWindow` per screen (`Variants` over `Quickshell.screens`), anchored top/bottom/right, transparent. Column of thirds: `ClockWidget`, `Repeater` over `Hyprland.workspaces`, `BatteryWidget`. Width = `SidebarState.expanded ? 100 : 30` |
| `ClockWidget.qml` | Pill showing `Time.time` |
| `Time.qml` | `pragma Singleton`: `SystemClock` formatted `hh:mm`. Uses `SystemClock.Minutes` precision — seconds aren't displayed, and the quickshell docs note Minutes improves battery life (fewer wake-ups/repaints) |
| `BatteryWidget.qml` | Pill showing battery % from `Quickshell.Services.UPower` |
| `SidebarState.qml` | `pragma Singleton`: `expanded` bool + `toggle()` |
| `Theme.qml` | Active-theme palette loader: `FileView` on `~/.config/themes/current/palette.json` (`watchChanges`, noir defaults) exposing `bg`/`bgSolid`/`text`/`accent`/`warn` |

## Styling

Clock + battery are pills: `Rectangle` with `radius = 999`, bold 10pt uppercase text, 20px horizontal / 10px vertical margins. Workspace entries are pills too, dimmed unless `active`. Colours come from `Theme.qml` (see table) — `theme-set` restarts the bar on switch since the swap replaces the whole `current/` dir.

## Battery logic

- `percentage` is a plain property binding to `UPower.displayDevice.percentage` (0–1, rendered as `%`) — event-driven over DBus, no polling. (A redundant `Connections` handler used to overwrite it, breaking the binding on first fire; removed.)
- Text turns red (`#ff4d42`) below 15%, white otherwise.

## Dependencies

- `upower` — battery data (in `packages.yaml`).
- `qt6-declarative` — pulled in as a quickshell dependency; provides **`qmlls6`**, the QML language server used by Neovim (`vim.lsp.enable` list includes `qmlls` with `cmd = { "qmlls6" }`). See `neovim.md`.

## Extending

New widget = new `.qml` file referenced from `Bar.qml` (auto-reloads on save when quickshell is running). The bar window is a plain `PanelWindow` — add a `TrayWidget`, `MediaWidget`, etc. as siblings of `ClockWidget`.
