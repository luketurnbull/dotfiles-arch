import QtQuick

// Morphing popout container: grows down from a bar pill, slides/resizes to
// follow the active pill, cross-fades content. All geometry animates on the
// same spatial curve — that simultaneity IS the "morph".
//
// Two-level structure (caelestia's ClipWrapper/Wrapper, rotated for a top
// bar): the root clips and scales height via offsetScale while the inner
// card slides out from behind the clip and morphs to the active popout's
// size. Declare content as PopoutLoader children (default property).
Item {
    id: root

    required property var hoverState  // PopoutState (per-screen hover)

    property string pinnedName: ""    // MenuState-driven (keyboard), "" = not pinned
    property real pinnedCenter: 0

    readonly property bool pinned: pinnedName !== ""
    readonly property bool hasCurrent: pinned || hoverState.hasCurrent
    readonly property string currentName: pinned ? pinnedName : hoverState.currentName
    readonly property real currentCenter: pinned ? pinnedCenter : hoverState.currentCenter

    default property alias popouts: stack.data

    readonly property Item activePopout: stack.children.find(c => c.shouldBeActive) ?? null

    // FINAL (non-animated) content size. Positioning must use this, never the
    // animated width/height: a Behavior on x whose target changes every frame
    // (because width is mid-animation) restarts every frame, lags, then does
    // a visible catch-up once the width settles.
    readonly property real contentWidth: (activePopout?.implicitWidth ?? 0) + Appearance.popoutPadding * 2
    readonly property real contentHeight: (activePopout?.implicitHeight ?? 0) + Appearance.popoutPadding * 2

    // 1 = closed, 0 = open. Drives the clip height + slide.
    property real offsetScale: hasCurrent ? 0 : 1

    clip: true
    visible: offsetScale < 1

    width: inner.width
    height: inner.height * (1 - offsetScale)
    // Centered under the current pill at its final size, clamped inside the
    // window. Changes exactly once per target change → one clean animation.
    x: Math.max(0, Math.min(parent.width - contentWidth, currentCenter - contentWidth / 2))

    Behavior on offsetScale {
        SpatialAnim {}
    }
    // Snap (don't animate) position at the moment of opening: on the frame
    // hasCurrent flips, offsetScale is still 1, so the Behavior is disabled
    // and x jumps straight under the pill. Only open-state morphs animate.
    Behavior on x {
        enabled: root.offsetScale < 1
        SpatialAnim {}
    }

    // Close-on-leave hover tracking (read by Bar). Topmost so hover is seen
    // even over future content buttons; NoButton so clicks fall through.
    readonly property bool hovered: hoverArea.containsMouse

    Rectangle {
        id: inner

        anchors.top: parent.top
        anchors.topMargin: (-height - 5) * root.offsetScale
        anchors.horizontalCenter: parent.horizontalCenter

        width: root.contentWidth
        height: root.contentHeight

        Behavior on width {
            SpatialAnim {}
        }
        Behavior on height {
            SpatialAnim {}
        }

        color: Theme.bg
        radius: Appearance.popoutRadius
        topLeftRadius: 0
        topRightRadius: 0

        Item {
            id: stack
            anchors.fill: parent
            anchors.margins: Appearance.popoutPadding
        }
    }

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }
}
