# Keyboard

Internal ThinkPad keyboard (`AT Translated Set 2 keyboard`) is remapped by
**kanata** (AUR `kanata-bin`), mirroring the split — a beekeeb **Piantor**
running Vial (`keyboards/piantor.vil`, repo-only export; edit via Vial Web /
vial-appimage).

kanata runs as a **systemd user service**, grabs only the internal keyboard at
evdev level (the Piantor is untouched — it does its own thing in firmware), and
emits a virtual keyboard that Hyprland sees as a normal device.

## Files

| What | Where |
|---|---|
| kanata config | `dot_config/kanata/kanata.kbd` → `~/.config/kanata/kanata.kbd` |
| user service | `dot_config/systemd/user/kanata.service` |
| restart hook | `run_onchange_after_restart-kanata.sh.tmpl` (restarts service when config changes) |
| Vial export | `keyboards/piantor.vil` (chezmoi-ignored) |

## Layout

Standard QWERTY with home-row mods mirroring the Piantor's Vial settings, plus
Caps Lock mapped to Escape. Tap a home-row key normally or hold it for its
modifier. Tapping term 200ms, plain tap-hold (no permissive hold / flow tap).

| Tap | Hold | Tap | Hold |
|---|---|---|---|
| `A` | Left Shift | `J` | Right Ctrl |
| `S` | Left Alt | `K` | Right Super |
| `D` | Left Super | `L` | Right Alt |
| `F` | Left Ctrl | `;` | Right Shift |

Every other key passes through unchanged, including Enter, Space, Backspace,
and apostrophe. There are no layers or thumb-key remaps.

## One-time setup (sudo, not chezmoi-managed)

```sh
# kanata needs to read evdev (input group) and create a virtual keyboard (uinput)
sudo groupadd -f uinput
sudo usermod -aG input,uinput luke
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/99-input.rules
echo uinput | sudo tee /etc/modules-load.d/uinput.conf
sudo modprobe uinput
sudo udevadm control --reload-rules && sudo udevadm trigger
# reboot — picks up group membership, /dev/uinput node, and any pending kernel update
# (then, in-session:)
systemctl --user enable --now kanata
```

Vial (already done, kept for reference) — `/etc/udev/rules.d/59-vial.rules`:

```
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
```

## Editing / tuning

- Edit `dot_config/kanata/kanata.kbd` → `chezmoi apply` restarts the service
  automatically (run_onchange hook). To restart manually:
  `systemctl --user restart kanata`.
- Validate syntax without applying: `kanata --cfg <file> --check`.
- Timings live in the `defalias` `tap-hold` entries (`200 200` = repress/hold ms).
  If fast typing misfires mods, try `tap-hold-release` variants or add
  `(require-prior-idle <ms>)` — deliberately omitted to match the split.
- Logs: `journalctl --user -u kanata -f`. `kanata -l` lists grabbable keyboards.

## Recovery

- Emergency exit: **LCtrl+Space+Esc** (kanata quits, stock keyboard returns).
- Broken config: service restart fails → stock keyboard; fix config, restart.
- Full stop: `systemctl --user stop kanata`.

## Gotchas

- `modprobe: Module uinput not found` → you're running an older kernel than the
  installed one (`uname -r` vs `pacman -Q linux`); modules for the running kernel
  were removed on update. Reboot — don't fight it.
- No remaps at the login screen / TTY (user service only runs in-session).
- Trackpad disable-while-typing: if libinput stops recognising the kanata
  keyboard as internal, create `/etc/libinput/local-overrides.quirks`:

  ```
  [Serial Keyboards]
  MatchUdevType=keyboard
  MatchName=*[Kk]anata*
  AttrKeyboardIntegration=internal
  ```
- Hyprland: never add a disable rule for the `Kanata` virtual device in
  `dot_config/hypr/config/devices.lua`.
