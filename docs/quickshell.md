# Quickshell

Status bar in QML: `dot_config/quickshell/` → `~/.config/quickshell/`.

## Layout

Top bar, pill-shaped widgets on a transparent background. Height is content-driven (`Math.max` of the two pill groups), never hardcoded.

| File | Role |
|---|---|
| `shell.qml` | Root: `Scope` instantiating `Bar` + `StatsSidebar`; force-instantiates `MenuState` |
| `Bar.qml` | One `PanelWindow` per screen; layout only (positions `Workspaces`, clock pill, battery pill) |
| `Workspaces.qml` | Workspace pills (`Row` + `Repeater` over `Hyprland.workspaces`); owns the `Hyprland` import |
| `ClockWidget.qml` | `StyledText` showing `Time.time` |
| `BatteryWidget.qml` | `StyledText` showing a Nerd Font battery glyph |
| `Sidebar.qml` | Reusable full-height sidebar shell: persistent `PanelWindow`, card slides via `offsetScale`; content via default-property `Column`; keyboard nav built in |
| `StatsSidebar.qml` | `Sidebar` per screen (`Variants`): CPU/RAM/BAT ring gauges; `menuName: "battery"` |
| `RingGauge.qml` | 0–1 ring gauge (Canvas-drawn track + value arc), % in center, label below |
| `BarMenu.qml` | Reusable `PopupWindow` shell anchored to a bar item; content via default-property `Column` |
| `MenuState.qml` | `pragma Singleton`: which menu is open + `GlobalShortcut` (`ALT+B` → `quickshell:batterymenu`) |
| `SysStats.qml` | `pragma Singleton`: CPU/RAM polling via `FileView` on `/proc/stat` + `/proc/meminfo` (2s) |
| `StyledText.qml` | Shared `Text` base: bold, uppercase, `Theme.text` color, `Appearance.fontSize` |
| `Theme.qml` | `pragma Singleton`: color palette from `palette.json` |
| `Appearance.qml` | `pragma Singleton`: theme-independent sizing (font size, bar margins) |
| `Time.qml` | `pragma Singleton`: `SystemClock` with `Minutes` precision |

All positioned with `anchors.top: parent.top`. Left: workspaces. Center: clock pill. Right: battery pill (clickable, opens the stats sidebar).

## Styling

- Pills: `Rectangle` with `radius: height / 2` (fully circular), 20px horizontal / 8px vertical padding.
- Window margins from `Appearance.barMargin` (mirrors hyprland `gaps_out`), so pills float off the screen edges.
- Workspace pills dimmed (opacity 0.6) unless active.
- All text is `StyledText`: bold, uppercase, `Appearance.fontSize` (11).
- Colors from the `Theme` singleton (reads `~/.config/themes/current/palette.json`); sizes from the `Appearance` singleton. Components read both directly — no prop-passing.

## Battery logic

- `percentage` is a plain property bound to `UPower.displayDevice.percentage` (0–1), event-driven over DBus, no polling.
- Text shows a Nerd Font glyph picked from a 10-step array (`floor(percentage * 10)`, clamped to 9).
- `charging` (from `UPowerDevice.state`) swaps to the charging glyph set.
- Glyphs turn `Theme.warn` red below 15%.

## Menus (popup system)

- `MenuState.openMenu` (singleton) holds the open menu's name or `""`. `toggle(name)` / `close()`. One menu open at a time by construction.
- Keyboard: `GlobalShortcut` in `MenuState.qml` (`hyprland_global_shortcuts_v1`, no XDPH), bound in hyprland via `hl.bind("ALT + B", hl.dsp.global("quickshell:batterymenu"))`. Works even while the popup holds the input grab (compositor-level).
- `BarMenu.qml` = `PopupWindow` (xdg-popup) anchored via `anchor.item` to a bar pill; `anchor.edges/gravity` hang it below, right-aligned. `grabFocus: true` → click-outside dismisses.
- Content is pluggable: subclass `BarMenu`, set `menuName`, declare children (they land in the card's `Column` via default-property alias).
- Stats: `SysStats` singleton polls `/proc/stat` (CPU, needs 2 samples — shows `--` for the first ~2s) and `/proc/meminfo` (uses `MemAvailable`, never `MemFree`). `FileView` + `Timer`, zero subprocesses.
- Battery details come from `UPower.displayDevice` (event-driven, no polling): `timeToFull`/`timeToEmpty` (seconds), `healthPercentage`, `changeRate` (W).

## Sidebar (stats panel)

- `Sidebar.qml` = persistent (always-mapped) `PanelWindow` strip (`Appearance.sidebarWidth`, 300) anchored top/bottom/right, `ExclusionMode.Ignore` (pure overlay — tiled windows never move), namespace `quickshell:sidebar`. The compositor never animates it; the card slides QML-side via `offsetScale` (0 = open, 1 = closed) → negative `anchors.rightMargin` + fade, with hyprland's own curves: `Appearance.curveDecel` 350ms in, `curveAccel` 250ms out (mirrors `layersIn`/`layersOut` in `config/animations.lua`).
- Card: flush against the right screen edge, 80% of screen height, vertically centered, no border/radius — plain `Theme.bgSolid` panel. Content is a centered `Column`.
- Lifecycle guards while closed (the window is always mapped): `keyboardFocus` flips `OnDemand` (open) ↔ `None` (closed) — a hidden always-mapped window must never hold keyboard focus; `mask` is `Region { item: card }` while open/animating and an empty `Region` when fully closed — right-edge clicks fall through.
- Click-outside dismiss via `HyprlandFocusGrab` (`active: open`, `onCleared: MenuState.close()`).
- Keyboard nav: the card has `focus: true`; `Keys` handles Escape (close), Up/Down (move `selectedIndex`, wraps), Enter (`activated(index)` signal). Subclasses set `itemCount`, highlight `selectedIndex`, react to `activated`. `StatsSidebar` currently has no action rows (`itemCount: 0` — nav infra is ready for some).
- One instance per screen (`Variants` inside `StatsSidebar.qml`), gated to `Hyprland.focusedMonitor` — same trick as `BarMenu`.
- Content = default-property `Column` in the card, same pattern as `BarMenu` subclasses.
- `RingGauge.qml` animates between `SysStats` 2s samples via `Behavior on degree` (350ms `curveDecel`).

## Gotchas

- Battery glyph codepoints in the `F089x` block are **non-contiguous** — the charging set interleaves it (10/50/70 → `F089C/D/E`, rest in `F008x`). Both arrays are hardcoded 10-entry tables (index = `floor(pct × 10)` clamped to 9); dropping an entry shows `undefined` (rendered as "UNDEFINED" thanks to `Font.AllUppercase`).
- If the battery shows as tofu/blank, Qt6 font fallback didn't kick in (QTBUG-110502) — add `font.family: "Symbols Nerd Font"` to `BatteryWidget.qml` (confirm the exact family with `fc-list | grep -i symbols`).
- **Singletons instantiate lazily** — `shell.qml` holds a `readonly property var _menuState: MenuState` reference or the `GlobalShortcut` never registers (`hyprctl globalshortcuts` stays empty).
- **`grabFocus` writes `visible = false` directly on dismissal**, breaking any `visible` binding — `BarMenu` keeps `visible` imperative and mirrors dismissals back into `MenuState` via `onVisibleChanged`.
- One `BarMenu` instance exists **per screen** (Bar is `Variants`) — gated to `Hyprland.focusedMonitor.name === screenName` so the two popups never fight over the xdg-popup input grab.
- `UPowerDevice.healthPercentage` is **0–100** (raw UPower `Capacity`), unlike `percentage` which quickshell normalizes to 0–1. `displayDevice` is an aggregate — if health shows `N/A`, iterate `UPower.devices` for `isLaptopBattery`.
- Files with `pragma Singleton` using the `Singleton` base type still need `import Quickshell` — a missing import surfaces as `Singleton is not a type` with a misleading cascade of "Type X unavailable" errors through every other singleton.
- **Window sizes are integers; text widths are fractional.** A window sized to `content.implicitWidth` (e.g. 123.4) gets rounded down and clips a 1px border drawn at the window edge — extra-visible at 1.25 display scale. `BarMenu` sizes itself `Math.ceil(card.implicitWidth) + 2` with a 2px right/bottom margin on the card. Keep borders off the window edge.
- **`Sidebar` is always mapped** — never gate it with `visible: false`; that would unmap the window instantly and kill the slide-out animation. Open/close state is `offsetScale` + `mask` + `keyboardFocus` only.
- **Gauge tracks must not use a palette color** — some themes set `accent == border` in `palette.json`, which merged track and value into what looked like a permanently full circle (values were correct; it was a color collision, verified by rendering the Canvas offscreen via `qml6 -platform offscreen` + `canvas.save()`). Track = `Theme.text` at 20% `globalAlpha` — collision-proof. The value arc is capped just under 360° so round caps survive.
- `WlrKeyboardFocus.Exclusive` breaks Hyprland click-outside dismissal (0.49+); `OnDemand` behaves as exclusive without the breakage (same finding as end-4's dots).
- `hyprctl dispatch global ...` is parsed as Lua by the hypr Lua DSL — use `hyprctl dispatch 'hl.dsp.global("quickshell:batterymenu")'` to trigger the sidebar from a script/terminal.

## Extending

New widget = new `.qml` file (root `StyledText` if it shows text), reading the `Theme`/`Appearance` singletons directly. Add the instance to a pill in `Bar.qml` (clock pill for center, battery pill `Row` for right). Quickshell auto-reloads on save.

New menu = `XMenu.qml` subclassing `BarMenu` (set `menuName`, declare content), instantiated in `Bar.qml` next to its pill with `anchorItem` + `screenName: modelData.name`. Add a `GlobalShortcut` in `MenuState.qml` + matching `hl.dsp.global` bind for keyboard. Planned: Bluetooth, WiFi, sound. Future upgrades: hover triggers (MouseArea + exit-delay Timer), graphical bars inside `contentColumn`, GPU% (Intel i915 needs `intel_gpu_top` + setcap or `dev.i915.perf_stream_paranoid=0`).

New sidebar panel = another `Sidebar` instantiation (or subclass) with its own `menuName` + `GlobalShortcut` in `MenuState.qml` — see `StatsSidebar.qml`. Add keyboard-nav rows: bump `itemCount`, highlight on `selectedIndex`, handle `activated(index)`.
