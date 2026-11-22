import QtQuick

// Shared fade curve: M3 expressive default effects (caelestia tokens).
NumberAnimation {
    duration: Appearance.durEffects
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Appearance.curveEffects
}
