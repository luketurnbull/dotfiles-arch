import QtQuick
import Quickshell.Hyprland

Row {
    spacing: 2

    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            id: workspace
            required property var modelData

            opacity: workspace.modelData.active ? 1 : 0.6
            color: Theme.bgSolid
            // Same border as a hyprland active window (border_size = 1).
            border.width: workspace.modelData.active ? 1 : 0
            border.color: Theme.border
            radius: 6
            implicitWidth: workspaceLabel.implicitWidth + 18
            implicitHeight: workspaceLabel.implicitHeight + 4

            StyledText {
                id: workspaceLabel
                anchors.centerIn: parent
                text: "%1".arg(workspace.modelData.name)
            }
        }
    }
}
