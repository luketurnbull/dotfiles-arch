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

    // Animation curves — mirror hyprland config/animations.lua (M3 emphasized).
    readonly property var curveDecel: [0.05, 0.7, 0.1, 1, 1, 1]
    readonly property var curveAccel: [0.3, 0, 0.8, 0.15, 1, 1]
    readonly property var curveStandard: [0.2, 0, 0, 1, 1, 1]

    // Durations (ms) in the spirit of hyprland's layer speeds (in 4 / out 3).
    property int durEnter: 350
    property int durExit: 250
    property int durTick: 200
}
