# Hyprland

Config: `dot_config/hypr/` → `~/.config/hypr/`. **Lua DSL** (`hl.*` API), entry `hyprland.lua`.
`.luarc.json` points lua-language-server at `/usr/share/hypr/stubs` for `hl.*` completions.

## Files

| File | Purpose |
|---|---|
| `hyprland.lua` | Entry: requires the modules below, autostart, maximize-suppress window rule |
| `variables.lua` | `mainMod = SUPER`, app commands (ghostty, zen-browser, obsidian, obs, blender) |
| `monitors.lua` | Dynamic monitor setup + lid-switch handling |
| `appearance.lua` | Gaps/borders/rounding/blur + `toggleGaps()` recording mode |
| `animations.lua` | Custom beziers/springs + animation definitions |
| `keybinds.lua` | All keybinds |
| `devices.lua` | Disables internal keyboard |
| `hyprpaper.conf` | Wallpaper (not Lua) |
| `monitor-added.sh` | socat hotplug watcher — **not autostarted, currently unused** |
| `wallpapers/` | `cherry-blossom.jpg` (active), `neon-mountain.png` (unused) |

## Autostart (`hyprland.start`)

1. `systemctl enable --user app-com.mitchellh.ghostty.service`
2. `hyprpaper`
3. `swayosd-server`
4. `swaync`
5. `quickshell`

Window rule: `suppress_event = "maximize"` for all classes.

## Monitors (`monitors.lua`)

Fully dynamic — no hardcoded external output name:

- `hl.get_monitors()`: any monitor that isn't `eDP-1` is treated as external.
- External present → external at `0x0` scale **1.25**, laptop `auto-down` scale 1.25.
- No external → laptop at `0x0`.
- Lid-switch binds (locked): lid **closed** → `eDP-1` disabled; lid **open** → re-enabled.
- Exports `configureAll()`; `monitor-added.sh` listens on `$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock` for `monitoraddedv2`/`monitorremovedv2` and re-runs it via `hyprctl eval` — but nothing starts the script, so hotplug currently relies on Hyprland's own behavior.

## Keybinds (`keybinds.lua`, mainMod = SUPER)

| Bind | Action |
|---|---|
| `SUPER+T` / `SUPER+B` | ghostty / zen-browser |
| `SUPER+N` / `SUPER+SHIFT+S` / `SUPER+SHIFT+B` | obsidian / obs / blender |
| `ALT+G` | toggle 16:9 recording gaps (notification shows mode) |
| `SUPER+W` | close window |
| `SUPER+hjkl` / arrows | focus |
| `SUPER+SHIFT+hjkl` / arrows | move window |
| `SUPER+0-9` / `SUPER+SHIFT+0-9` | workspace 1–10 / move to workspace |
| `SUPER+F12` / `F11` / `F10` | volume up (repeating) / down (repeating) / mute (locked) — via `swayosd-client` |
| `SUPER+SHIFT+M` | exit Hyprland |

## Appearance (`appearance.lua`)

- `gaps_in = 5`; `gaps_out` defaults to **recording layout** `{ top 0, bottom 10, left/right 362 }` — centers a 16:9-safe area on the 3440px ultrawide. `ALT+G` toggles to normal `{ 0, 10, 10, 10 }`.
- Border 1px; active = gradient `rgb(3b4261)` → `rgb(7aa2f7)` @ 45°, inactive `rgb(1a1b26)`.
- `rounding = 16`, `rounding_power = 4`; opacity 0.98 active / 0.94 inactive.
- Blur: size 4, passes 1, `vibrancy_darkness = 0.2`.
- Font `Inter Regular`; misc: no logo/splash, middle-click paste, force default wallpaper off... (`force_default_wallpaper = true`, `disable_hyprland_logo = true`, `disable_splash_rendering = true`, `middle_click_paste = true`).

## Animations (`animations.lua`)

Beziers: `easeOutQuint`, `easeInOutCubic`, `linear`, `almostLinear`, `quick`. Spring: `easy` (mass 1, stiffness 70, dampening 15). Windows use the `easy` spring (`windowsIn` pops in at 87%), workspaces cross-fade (`almostLinear`), layers fade with `easeOutQuint`/`linear`.

## Devices (`devices.lua`)

`at-translated-set-2-keyboard` (internal ThinkPad keyboard) is **disabled** — an external keyboard is expected. Re-enable here if needed.

## Wallpaper (`hyprpaper.conf`)

`splash = false`; `cherry-blossom.jpg` (cover) on `DP-2` and `eDP-1`.
