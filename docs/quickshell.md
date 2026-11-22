# Quickshell

Status bar in QML: `dot_config/quickshell/` → `~/.config/quickshell/`.

## Layout

Top bar, pill-shaped widgets on a transparent background. The window is taller than the visible bar: content-driven strip height + `Appearance.popoutMaxHeight` of invisible, click-through popout space below.

| File | Role |
|---|---|
| `shell.qml` | Root: `Scope` instantiating `Bar`; force-instantiates `MenuState` |
| `Bar.qml` | One `PanelWindow` per screen: strip layout (workspaces, clock, battery) + all popout wiring (hover, pinned, mask, focus grab) |
| `Workspaces.qml` | Workspace pills (`Row` + `Repeater` over `Hyprland.workspaces`) |
| `ClockWidget.qml` | `StyledText` showing `Time.time` |
| `BatteryWidget.qml` | `StyledText` showing a Nerd Font battery glyph |
| `MorphPopout.qml` | Morphing popout container (below); content via default-property `PopoutLoader` children |
| `PopoutLoader.qml` | One named popout in the stack; loads-then-fades-in, fades-out-then-unloads |
| `PopoutState.qml` | Per-screen hover state (`currentName`, `currentCenter`, `hasCurrent`) |
| `SpatialAnim.qml` / `EffectsAnim.qml` | Shared animation presets (M3 expressive spatial / effects) |
| `BatteryPopout.qml` | Battery details: glyph + %, time remaining/full, health + watts |
| `MenuState.qml` | `pragma Singleton`: pinned popout name + `GlobalShortcut` (`ALT+B` → `quickshell:batterymenu`) |
| `StyledText.qml` | Shared `Text` base: bold, uppercase, `Theme.text`, `Appearance.fontSize` |
| `Theme.qml` | `pragma Singleton`: color palette from `palette.json` |
| `Appearance.qml` | `pragma Singleton`: theme-independent sizing, animation curves/durations |
| `Time.qml` | `pragma Singleton`: `SystemClock` with `Minutes` precision |

Left: workspaces. Center: clock pill (hover/click → clock popout — content still a dummy). Right: battery pill (hover/click/ALT+B → battery popout).

## Styling

- Pills: `Rectangle` with `radius: height / 2` (fully circular), 20px horizontal / 8px vertical padding; top corners square (hug the screen edge).
- Popout card: `Theme.bg`, `Appearance.popoutRadius` (12) bottom corners only, `popoutPadding` (12).
- Window margins from `Appearance.barMargin` (mirrors hyprland `gaps_out`), so pills float off the screen edges.
- Workspace pills dimmed (opacity 0.6) unless active.
- All text is `StyledText`: bold, uppercase, `Appearance.fontSize` (11). Popout headers override `font.pointSize` per-instance.
- Colors from the `Theme` singleton (reads `~/.config/themes/current/palette.json`); sizes/curves from the `Appearance` singleton. Components read both directly — no prop-passing.

## Morph popouts

Caelestia-shell-style popouts, pure QML, all inside the bar window (caelestia's ClipWrapper/Wrapper mechanism rotated for a horizontal bar):

- **Window**: `stripHeight + popoutMaxHeight` tall. `exclusiveZone: stripHeight` set explicitly — setting it implies `ExclusionMode.Normal`; the default `Auto` would reserve the *whole* window height and shove tiled windows down.
- **Mask**: input region = bar strip ∪ popout (while `offsetScale < 1`); everything else in the reserved area is click-through.
- **State**: hover is per-screen (`PopoutState`, lives in `Bar`); pinned is global (`MenuState.openMenu`, via shortcut or pill click). `MorphPopout` merges the two — pinned wins, and pins apply only on the focused screen.
- **The morph**: two nested items. Root clips and scales height via `offsetScale` (1 = closed); the inner card slides out from behind the clip (`anchors.topMargin: (-height - 5) * offsetScale`) and animates to the active popout's size. `x` centers the card under the active pill, clamped to the window. Switching pills = simultaneous slide + resize + cross-fade, all on `SpatialAnim` (M3 expressive `[0.38, 1.21, 0.22, 1]`, 500ms — the overshoot is the feel; fades use `EffectsAnim`, 200ms).
- **Close**: unpinned closes `popoutCloseDelay` (250ms) after the pointer leaves pill + popout — hover intent, so pill → popout and pill → pill crossings don't flicker. Pinned closes via shortcut / pill click / Esc / click-outside (`HyprlandFocusGrab`).
- **Content swap**: `PopoutLoader` activates on the *same frame* it becomes current (size available immediately), then fades in; fades out before deactivating. Popout sizes are content-driven (`implicitWidth/Height`).
- **Keyboard**: while pinned, `WlrLayershell.keyboardFocus` flips `None` → `OnDemand`, a `keySink` item takes focus, Esc → `MenuState.close()`.

## Battery logic

- `percentage` is a plain property bound to `UPower.displayDevice.percentage` (0–1), event-driven over DBus, no polling.
- Pill shows a Nerd Font glyph picked from a 10-step array (`floor(percentage * 10)`, clamped to 9). `charging` (from `UPowerDevice.state`) swaps to the charging glyph set. Glyphs turn `Theme.warn` red below 15%.
- Popout: % + time estimate (`timeToEmpty` on battery, `timeToFull` while charging, "Fully charged" at 100%, "Calculating..." while UPower has no estimate yet), `healthPercentage`, `changeRate` (W). `UPower.onBattery` picks the branch.

## Gotchas

- Battery glyph codepoints in the `F089x` block are **non-contiguous** — the charging set interleaves it (10/50/70 → `F089C/D/E`, rest in `F008x`). Both arrays are hardcoded 10-entry tables (index = `floor(pct × 10)` clamped to 9); dropping an entry shows "UNDEFINED" (thanks to `Font.AllUppercase`).
- If the battery shows as tofu/blank, Qt6 font fallback didn't kick in (QTBUG-110502) — add `font.family: "Symbols Nerd Font"` to `BatteryWidget.qml` (confirm the exact family with `fc-list | grep -i symbols`).
- **Singletons instantiate lazily** — `shell.qml` holds a `readonly property var _menuState: MenuState` reference or the `GlobalShortcut` never registers (`hyprctl globalshortcuts` stays empty).
- `UPowerDevice.healthPercentage` is **0–100** (raw UPower `Capacity`), unlike `percentage` which quickshell normalizes to 0–1. `displayDevice` is an aggregate — if health shows `N/A`, iterate `UPower.devices` for `isLaptopBattery`.
- Files with `pragma Singleton` using the `Singleton` base type still need `import Quickshell` — a missing import surfaces as `Singleton is not a type` with a misleading cascade of "Type X unavailable" errors through every other singleton.
- **Never animate position from an animated size.** A `Behavior on x` whose target derives from a mid-animation width restarts every frame, lags, then visibly catches up (two-stage drift). Position from the *final* content size; animate size only for the visual. (First morph bug.)
- **Snap position on open**: the `Behavior on x` is `enabled: offsetScale < 1`, so on the opening frame (offsetScale still 1) x jumps straight under the pill instead of animating from the stale closed position. Only open-state morphs animate position. (Caelestia does the same in ClipWrapper.)
- **`PopoutLoader` transition ordering matters**: `PropertyAction { active }` *before* the fade-in, fade-out *before* deactivation — otherwise the container morphs to zero size mid-swap.
- `WlrKeyboardFocus.Exclusive` breaks Hyprland click-outside dismissal (0.49+); `OnDemand` behaves as exclusive without the breakage (same finding as end-4's dots).
- `hyprctl dispatch global ...` is parsed as Lua by the hypr Lua DSL — use `hyprctl dispatch 'hl.dsp.global("quickshell:batterymenu")'` to trigger from a script/terminal.
- **chezmoi v2 `apply` never deletes targets** whose source files were removed — `rm` them in `~/` by hand (and unmanaged experiment files are invisible to `chezmoi status` entirely).
- **Multi-file applies race the live-reload**: quickshell can reload mid-apply with "X is not a type" for files written a moment later. Transient — `touch shell.qml` to force a clean reload before believing errors.

## Extending

New popout = 4 steps:

1. `MyPopout.qml` content component (`implicitWidth/Height` drive the morph size).
2. `PopoutLoader { name: "mine"; popout: popout; sourceComponent: MyPopout {} }` inside the `MorphPopout` in `Bar.qml`.
3. Register the pill in `popoutPills` (`"mine": myPill`) and call `openPopout("mine", myPill)` from its `MouseArea.onEntered` (+ `MenuState.toggle("mine")` on click).
4. Keyboard: add a `GlobalShortcut` in `MenuState.qml` + matching `hl.bind(..., hl.dsp.global("quickshell:..."))` in the hyprland config.

Planned: clock popout = calendar (`MonthGrid` + `DayOfWeekRow` from QtQuick.Controls, themed delegates — caelestia's dashboard calendar is the reference).
