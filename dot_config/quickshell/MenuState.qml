pragma Singleton

import Quickshell
import Quickshell.Hyprland

// Which bar menu is open ("" = none). Lives in a singleton so the
// GlobalShortcut registers once, not once per screen (Bar is per-screen).
Singleton {
    id: root

    property string openMenu: ""

    function toggle(name: string): void {
        openMenu = (openMenu === name) ? "" : name;
    }

    function close(): void {
        openMenu = "";
    }

    // Bound in hyprland as: hl.bind("ALT + B", hl.dsp.global("quickshell:batterymenu"))
    GlobalShortcut {
        name: "batterymenu"
        description: "Toggle battery/stats menu"
        onPressed: root.toggle("battery")
    }
}
