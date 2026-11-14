import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

// Full-height overlay sidebar. Persistent (always-mapped) transparent window;
// the card slides in/out via offsetScale with hyprland-matching curves, so the
// compositor never animates the window itself. Subclass via the default
// property (content lands in the column), like BarMenu.
//
// Keyboard nav for subclass content: set itemCount, highlight selectedIndex,
// react to activated(index). Escape closes, Up/Down move, Enter activates.
PanelWindow {
    id: root

    required property string menuName
    property string screenName: ""

    default property alias content: contentColumn.data

    property int selectedIndex: 0
    property int itemCount: 0
    signal activated(int index)

    readonly property bool onFocusedScreen: !!Hyprland.focusedMonitor && Hyprland.focusedMonitor.name === screenName
    readonly property bool open: MenuState.openMenu === menuName && onFocusedScreen

    anchors {
        top: true
        bottom: true
        right: true
    }

    color: "transparent"
    implicitWidth: Appearance.sidebarWidth
    // Persistent — mask/keyboardFocus below keep it inert while closed.
    visible: true

    WlrLayershell.namespace: "quickshell:sidebar"
    // Overlay: tiled windows never move (exclusive zone 0).
    exclusionMode: ExclusionMode.Ignore
    // Grab keyboard only while open; a hidden always-mapped window must never
    // hold focus. (Hyprland ≥0.49: OnDemand acts exclusive; real Exclusive
    // breaks click-outside-to-close.)
    WlrLayershell.keyboardFocus: open ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

    // 0 = open, 1 = closed. Drives slide, fade and mask.
    property real offsetScale: open ? 0 : 1

    Behavior on offsetScale {
        NumberAnimation {
            duration: root.open ? Appearance.durEnter : Appearance.durExit
            easing.type: Easing.BezierSpline
            easing.bezierCurve: root.open ? Appearance.curveDecel : Appearance.curveAccel
        }
    }

    // Input only on the card; nothing once fully closed, so the right screen
    // edge stays clickable.
    mask: offsetScale < 1 ? cardRegion : emptyRegion
    Region { id: cardRegion; item: card }
    Region { id: emptyRegion }

    // Click outside dismisses.
    HyprlandFocusGrab {
        active: root.open
        windows: [root]
        onCleared: MenuState.close()
    }

    onOpenChanged: {
        if (open) {
            selectedIndex = 0;
            card.forceActiveFocus();
        }
    }

    Rectangle {
        id: card
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: -width * root.offsetScale
        width: root.width
        height: root.height * 0.8

        color: Theme.bgSolid

        opacity: 1 - root.offsetScale
        visible: root.offsetScale < 1
        focus: true

        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_Escape) {
                MenuState.close();
            } else if (event.key === Qt.Key_Up && root.itemCount > 0) {
                root.selectedIndex = (root.selectedIndex - 1 + root.itemCount) % root.itemCount;
            } else if (event.key === Qt.Key_Down && root.itemCount > 0) {
                root.selectedIndex = (root.selectedIndex + 1) % root.itemCount;
            } else if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter) && root.itemCount > 0) {
                root.activated(root.selectedIndex);
            } else {
                return; // leave event.accepted = false
            }
            event.accepted = true;
        }

        Column {
            id: contentColumn
            anchors.centerIn: parent
            spacing: 6
        }
    }
}
