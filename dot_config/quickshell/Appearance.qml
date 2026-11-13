pragma Singleton

import Quickshell

// Sizing constants. Colors live in Theme.qml (per-theme, from palette.json);
// anything visual but theme-independent belongs here.
Singleton {
    // All bar text currently shares one size.
    property real fontSize: 11

    // Mirror hyprland gaps_out (appearance.lua), so pills float off the screen
    // edges. Desyncs while ALT+G recording gaps are active.
    property real barMargin: 5
}
