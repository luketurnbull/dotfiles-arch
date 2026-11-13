import QtQuick
import Quickshell

Scope {
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

            margins {
                top: 0
                left: Appearance.barMargin
                right: Appearance.barMargin
            }

            Workspaces {
                id: workspaces
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.left: parent.left
            }

            Rectangle {
                id: clock
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                color: Theme.bg
                radius: height / 2
                topLeftRadius: 0
                topRightRadius: 0
                implicitWidth: clockContent.implicitWidth + 40
                implicitHeight: clockContent.implicitHeight + 8

                Row {
                    id: clockContent
                    anchors.centerIn: parent
                    spacing: 12

                    ClockWidget { anchors.verticalCenter: parent.verticalCenter }
                    BatteryWidget { anchors.verticalCenter: parent.verticalCenter }
                }
            }
        }
    }
}
