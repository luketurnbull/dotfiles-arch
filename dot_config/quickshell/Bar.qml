import QtQuick
import Quickshell
import Quickshell.Hyprland

Scope {
    Theme {
        id: theme
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            color: "transparent"

            // Content-driven height — pills can never be clipped by the window.
            // workspaces.y accounts for the row's topMargin.
            implicitHeight: Math.max(workspaces.y + workspaces.implicitHeight, clock.implicitHeight)

            anchors {
                top: true
                left: true
                right: true
            }

            // Mirror hyprland gaps_out (appearance.lua): 5 all sides, so the
            // pills float off the screen edges. Hardcoded — desyncs while
            // ALT+G recording gaps are active.
            margins {
                top: 0
                left: 5
                right: 5
            }

            Row {
                id: workspaces
                spacing: 2
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.left: parent.left

                Repeater {
                    model: Hyprland.workspaces

                    Rectangle {
                        id: workspace
                        required property var modelData

                        opacity: workspace.modelData.active ? 1 : 0.6
                        color: theme.bgSolid
                        // Same border as a hyprland active window (border_size = 1).
                        border.width: workspace.modelData.active ? 1 : 0
                        border.color: theme.border
                        radius: height / 2
                        implicitWidth: workspaceLabel.implicitWidth + 18
                        implicitHeight: workspaceLabel.implicitHeight + 4

                        Text {
                            id: workspaceLabel
                            anchors.centerIn: parent
                            text: "%1".arg(workspace.modelData.name)
                            color: theme.text

                            font.bold: true
                            font.pointSize: 11
                            font.capitalization: Font.AllUppercase
                        }
                    }
                }
            }

            Rectangle {
                id: clock
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                color: theme.bg
                radius: height / 2
                topLeftRadius: 0
                topRightRadius: 0
                implicitWidth: clockContent.implicitWidth + 40
                implicitHeight: clockContent.implicitHeight + 8

                Row {
                    id: clockContent
                    anchors.centerIn: parent
                    spacing: 12

                    ClockWidget {
                        anchors.verticalCenter: parent.verticalCenter
                        color: theme.text
                    }

                    BatteryWidget {
                        anchors.verticalCenter: parent.verticalCenter
                        colorNormal: theme.text
                        colorWarning: theme.warn
                    }
                }
            }
        }
    }
}
