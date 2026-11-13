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

            // Mirror hyprland normal gaps_out (appearance.lua): 5 both sides.
            // Hardcoded — desyncs while ALT+G recording gaps are active.
            margins {
                left: 5
                right: 5
            }

            Row {
                id: workspaces
                spacing: 2
                anchors.top: parent.top
                anchors.left: parent.left

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

            ClockWidget {
                id: clock
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: theme.bg
                textColor: theme.text
            }

            BatteryWidget {
                id: battery
                anchors.top: parent.top
                anchors.right: parent.right
                color: theme.bg
                colorNormal: theme.text
                colorWarning: theme.warn
            }
        }
    }
}
