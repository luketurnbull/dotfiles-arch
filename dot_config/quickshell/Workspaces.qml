import QtQuick
import Quickshell.Hyprland

Row {
    spacing: 2

    Repeater {
        model: 9

        Rectangle {
            id: workspace
            required property int index

            property var ws: Hyprland.workspaces.values.find(w => w.id == index + 1)
            property bool exists: !!ws
            property bool isActive: exists && ws.active

            function getOpacity() {
                if (isActive) {
                    return 1;
                }

                if (exists) {
                    return 0.75;
                }

                return 0.25;
            }

            opacity: getOpacity()
            color: Theme.bgSolid
            // Same border as a hyprland active window (border_size = 1).
            border.width: isActive
            border.color: Theme.border
            radius: 6
            implicitWidth: workspaceLabel.implicitWidth + 18
            implicitHeight: workspaceLabel.implicitHeight + 4

            StyledText {
                id: workspaceLabel
                anchors.centerIn: parent
                text: "%1".arg(workspace.index + 1)
            }
        }
    }
}
