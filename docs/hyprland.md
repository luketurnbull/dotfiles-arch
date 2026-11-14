# Hyprland

Config: `dot_config/hypr/` → `~/.config/hypr/`. **Lua DSL** (`hl.*` API), entry `hyprland.lua`.
`dot_luarc.json` → `~/.config/hypr/.luarc.json` points lua-language-server at `/usr/share/hypr/stubs` for `hl.*` completions.

## Layout

Entry `hyprland.lua` only requires the `config/*` modules and sets one window rule.
Modules live in `config/`, shared helpers in `lib/`. `require` paths are relative to
`hyprland.lua` (`.` separator); each `require` is scope-isolated by Hyprland, so an
error in one module doesn't kill the others.

| File | Purpose |
|---|---|
| `hyprland.lua` | Entry: requires the modules below + maximize-suppress window rule |
| `config/variables.lua` | `mainMod = SUPER`, app commands (ghostty, helium AppImage, obsidian, obs, blender) |
| `config/monitors.lua` | Dynamic monitor setup, lid-switch handling, native hotplug events |
| `config/appearance.lua` | Gaps/borders/rounding/blur + `toggleGaps()` recording mode |
| `config/animations.lua` | Custom beziers + animation definitions |
| `config/keybinds.lua` | All keybinds |
| `config/devices.lua` | Disables internal keyboard |
| `config/autostart.lua` | `hyprland.start` autostart list |
| `lib/theme.lua` | Loads border colours from the active theme (written by `theme-set`); fallback noir |
| `hyprpaper.conf` | Wallpaper (not Lua; hardcodes `DP-2` + `eDP-1`) |
| `wallpapers/` | `cherry-blossom.jpg` (active), `neon-mountain.png` (unused) |

## Autostart (`config/autostart.lua`)

On `hyprland.start` (fires once, not on reload):

1. `systemctl enable --user app-com.mitchellh.ghostty.service`
2. `hyprpaper`
3. `swayosd-server`
4. `swaync`
5. `quickshell`

Window rule (in entry): `suppress_event = "maximize"` for all classes.

## Monitors (`config/monitors.lua`)

Fully dynamic — no hardcoded external output name:

- `hl.get_monitors()`: any monitor that isn't `eDP-1` is treated as external.
- External present → external at `0x0` scale **1.25**, laptop `auto-down` scale 1.25.
- No external → laptop at `0x0`.
- Lid-switch binds (locked): lid **closed** → `eDP-1` disabled, but only when an
  external monitor is present (zero-monitor guard — never disables the last display);
  lid **open** → re-enabled.
- Hotplug: `hl.on("monitor.added")` / `hl.on("monitor.removed")` → `configureAll()`
  deferred through `hl.timer(..., { type = "oneshot", timeout = 1 })`. Deferring on
  purpose: running monitor reconfig synchronously inside the event-handler call stack
  has crashed Hyprland in the past (see omarchy#18676). This replaces the old socat
  `monitor-added.sh` watcher (deleted; `socat` dropped from `packages.yaml`).
- Exports `configureAll()` (usable via `hyprctl eval`).

## Keybinds (`config/keybinds.lua`, mainMod = SUPER)

| Bind | Action |
|---|---|
| `SUPER+T` / `SUPER+B` | ghostty / helium AppImage |
| `SUPER+N` / `SUPER+SHIFT+S` / `SUPER+SHIFT+B` | obsidian / obs / blender |
| `ALT+G` | toggle 16:9 recording gaps |
| `ALT+B` | toggle quickshell stats sidebar (`hl.dsp.global("quickshell:batterymenu")` → `GlobalShortcut` in `MenuState.qml`) |
| `SUPER+W` | close window |
| `SUPER+hjkl` / arrows | focus (one loop over direction table) |
| `SUPER+SHIFT+hjkl` / arrows | move window (same loop) |
| `SUPER+0-9` / `SUPER+SHIFT+0-9` | workspace 1–10 / move to workspace |
| `SUPER+F12` / `F11` / `F10` | volume up (repeating) / down (repeating) / mute (locked) — via `swayosd-client` |
| `SUPER+SHIFT+M` | exit Hyprland |

## Appearance (`config/appearance.lua`)

- Border colours come from `lib/theme.lua` (active theme; fallback noir
  `rgb(444444)` / `rgb(000000)`); border 1px.
- `gaps_in = 2`; `gaps_out` defaults to **normal** `{ top 2, bottom 5, left/right 5 }`.
  `ALT+G` toggles to recording `{ top 2, bottom 5, left/right 362 }` — centers a
  16:9-safe area on the 3440px ultrawide.
- `rounding = 16`, `rounding_power = 4`; opacity 0.95 active / 0.90 inactive.
- Blur: size 4, passes 3, brightness 1, vibrancy 1, `vibrancy_darkness = 0.2`.
- Font `Inter Regular`; misc: `force_default_wallpaper`, `disable_hyprland_logo`,
  `disable_splash_rendering`, `middle_click_paste`.

## Animations (`config/animations.lua`)

Material 3 "emphasized" scheme (speeds in deciseconds). Beziers: `emphasizedDecel`
(enters/moves), `emphasizedAccel` (exits), `standard` (fades/border). Windows pop in
80% @3 / out 90% @2, moves slide @3; workspaces **slide** @5 (In/Out inherit; special
slidevert @4); layers slide (in @4, out @3); fades @2–3; border/zoomFactor @5/@3
`standard`. No spring curves, no `global` override — every leaf set explicitly.

## Devices (`config/devices.lua`)

`at-translated-set-2-keyboard` (internal ThinkPad keyboard) is **disabled** — an
external keyboard is expected. Re-enable here if needed.

## Wallpaper (`hyprpaper.conf`)

`splash = false`; `cherry-blossom.jpg` (cover) on `DP-2` and `eDP-1`. Note: `DP-2` is
hardcoded — if the external output name changes, update it here (hyprpaper isn't Lua,
can't follow `monitors.lua`'s dynamic detection).
