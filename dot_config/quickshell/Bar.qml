import Quickshell
import QtQuick
import Quickshell.Hyprland

Scope {
    Theme { id: theme }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            color: "transparent"
            implicitHeight: 30

            anchors {
                top: true
                left: true
                right: true
            }

            BatteryWidget {
                id: battery
                anchors.top: parent.top
                anchors.left: parent.left
                color: theme.bg
                colorNormal: theme.text
                colorWarning: theme.warn
            }

            ClockWidget {
                id: clock
                anchors.centerIn: parent
                color: theme.bg
                textColor: theme.text
            }

            Row {
                id: workspaces
                spacing: 2
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: 4

                Repeater {
                    model: Hyprland.workspaces

                    Pill {
                        id: workspace
                        required property var modelData

                        opacity: workspace.modelData.active ? 1 : 0.6
                        color: theme.bgSolid
                        text: "%1".arg(workspace.modelData.name)
                        textColor: theme.text
                    }
                }
            }
        }
    }
}
