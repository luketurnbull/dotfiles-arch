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
            implicitHeight: Math.max(workspaces.y + workspaces.implicitHeight, clock.implicitHeight, batteryPill.implicitHeight)

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

                ClockWidget { id: clockContent; anchors.centerIn: parent }
            }

            Rectangle {
                id: batteryPill
                anchors.top: parent.top
                anchors.right: parent.right

                color: Theme.bg
                radius: height / 2
                topLeftRadius: 0
                topRightRadius: 0
                implicitWidth: batteryWidget.implicitWidth + 40
                implicitHeight: batteryWidget.implicitHeight + 8

                BatteryWidget { id: batteryWidget; anchors.centerIn: parent }

                MouseArea {
                    anchors.fill: parent
                    onClicked: MenuState.toggle("battery")
                }
            }

            BatteryMenu {
                anchorItem: batteryPill
                screenName: modelData.name
            }
        }
    }
}
