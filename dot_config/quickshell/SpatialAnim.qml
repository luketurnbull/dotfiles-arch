import QtQuick

// Shared morph curve: M3 expressive default spatial (caelestia tokens).
// Use for geometry (x/width/height/offsetScale) — the overshoot is the feel.
NumberAnimation {
    duration: Appearance.durSpatial
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Appearance.curveSpatial
}
