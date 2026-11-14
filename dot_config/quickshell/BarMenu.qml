import QtQuick
import Quickshell
import Quickshell.Hyprland

// Popup shell anchored to a bar item. Content lands in the Column via the
// default property. BatteryMenu/BluetoothMenu/etc. subclass this.
PopupWindow {
    id: root

    required property Item anchorItem
    required property string menuName
    property string screenName: ""

    default property alias content: contentColumn.data

    anchor.item: anchorItem
    // Hang below the anchor, right-aligned: popup's top-right at the anchor's
    // bottom-right, growing down-left (keeps it on-screen at the right edge).
    anchor.edges: Edges.Bottom | Edges.Right
    anchor.gravity: Edges.Bottom | Edges.Left

    color: "transparent"
    // +2 slack on right/bottom: window sizes are integers (logical px), so a
    // fractional card width would clip the 1px border at the window edge
    // (visible at 1.25 display scale).
    implicitWidth: Math.ceil(card.implicitWidth) + 2
    implicitHeight: Math.ceil(card.implicitHeight) + 8

    // Click outside dismisses (xdg-popup grab).
    grabFocus: true

    // One popup per screen exists (Bar is Variants) — only the focused
    // screen's popup shows, so the two never fight over the input grab.
    readonly property bool onFocusedScreen: !!Hyprland.focusedMonitor && Hyprland.focusedMonitor.name === screenName
    property bool shouldShow: MenuState.openMenu === menuName && onFocusedScreen
    onShouldShowChanged: visible = shouldShow
    // grabFocus writes visible=false directly on dismissal; mirror into MenuState.
    onVisibleChanged: if (!visible && MenuState.openMenu === menuName) MenuState.close()

    Rectangle {
        id: card
        anchors.top: parent.top
        anchors.topMargin: 6
        anchors.right: parent.right
        anchors.rightMargin: 2

        color: Theme.bgSolid
        radius: 8
        border.color: Theme.border
        border.width: 1

        implicitWidth: contentColumn.implicitWidth + 28
        implicitHeight: contentColumn.implicitHeight + 18

        Column {
            id: contentColumn
            anchors.centerIn: parent
            spacing: 6
        }
    }
}
