import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            color: "transparent"
            implicitWidth: columnContainer.implicitWidth + 20

            anchors {
                top: true
                bottom: true
                right: true
            }

            Rectangle {
                id: columnContainer
                color: "transparent"
                radius: 20
                implicitWidth: columnBar.implicitWidth + 10
                implicitHeight: columnBar.implicitHeight + 20
                height: parent.height - 20
                anchors.centerIn: parent

                ColumnLayout {
                    id: columnBar

                    property real rows: 3

                    implicitWidth: SidebarState.expanded ? 250 : 40
                    height: parent.height - 10
                    anchors.horizontalCenter: columnContainer.horizontalCenter

                    Rectangle {
                        color: "transparent"
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: parent.height / columnBar.rows

                        ClockWidget {
                            id: clock
                            color: "#ee1a1b26"
                        }
                    }

                    Rectangle {
                        color: "transparent"
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: parent.height / columnBar.rows
                    }

                    Rectangle {
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: parent.height / columnBar.rows
                        color: "transparent"

                        BatteryWidget {
                            id: battery
                            color: "#ee1a1b26"
                            anchors.bottom: parent.bottom
                        }
                    }
                }
            }
        }
    }
}
