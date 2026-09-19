# Quickshell

Status bar in QML: `dot_config/quickshell/` → `~/.config/quickshell/`. quickshell `0.3.1`, autostarted by `hyprland.lua`. **Minimal starter bar — clock + battery only.**

## Files

| File | Role |
|---|---|
| `shell.qml` | Root `Scope` → `Bar {}` |
| `Bar.qml` | One `PanelWindow` per screen (`Variants` over `Quickshell.screens`), anchored top/left/right, transparent, height = clock + 10px. Hosts `ClockWidget` (centered) + `BatteryWidget` (right). |
| `ClockWidget.qml` | Pill showing `Time.time` |
| `Time.qml` | `pragma Singleton`: `SystemClock` (seconds precision) formatted `ddd d MMM hh:mm` |
| `BatteryWidget.qml` | Pill showing battery % from `Quickshell.Services.UPower` |

## Styling

Both widgets are pills: `Rectangle` with `color = "#ee1a1b26"` (TokyoNight bg at ~93% opacity), `radius = 999`, bold white 10pt uppercase text, 20px horizontal / 8px vertical margins.

## Battery logic

- Reads `UPower.displayDevice.percentage` (0–1), rendered as `%`.
- Text turns red (`#ff0000`) below 15%, white otherwise.
- A `Connections` handler on `onPercentageChanged` updates the value, guarded by `UPower.displayDevice.ready`.

## Dependencies

- `upower` — battery data (in `packages.yaml`).
- `qt6-declarative` — pulled in as a quickshell dependency; provides **`qmlls6`**, the QML language server used by Neovim (`vim.lsp.enable` list includes `qmlls` with `cmd = { "qmlls6" }`). See `neovim.md`.

## Extending

New widget = new `.qml` file referenced from `Bar.qml` (auto-reloads on save when quickshell is running). The bar window is a plain `PanelWindow` — add a `WorkspaceWidget`, `TrayWidget`, etc. as siblings of `ClockWidget`.
