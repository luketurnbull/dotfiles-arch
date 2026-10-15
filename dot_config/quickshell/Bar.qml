import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            color: "transparent"
            implicitWidth: columnContainer.implicitWidth + 10

            anchors {
                top: true
                bottom: true
                right: true
            }

            Item {
                id: columnContainer
                implicitWidth: columnBar.implicitWidth + 5
                height: parent.height - 20
                anchors.right: parent.right

                ColumnLayout {
                    id: columnBar
                    property real rows: 3

                    implicitWidth: SidebarState.expanded ? 200 : 40
                    height: parent.height - 10

                    Item {
                        implicitHeight: 5
                    }

                    Rectangle {
                        color: "transparent"
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: parent.height / columnBar.rows

                        ClockWidget {
                            id: clock
                            anchors.right: parent.right
                            color: "#ee1a1b26"
                        }
                    }

                    Rectangle {
                        id: middleContainer
                        color: "transparent"
                        Layout.preferredHeight: parent.height / columnBar.rows
                        Layout.preferredWidth: parent.width

                        ColumnLayout {
                            id: workspaces
                            spacing: 5
                            anchors.right: middleContainer.right

                            Repeater {
                                model: Hyprland.workspaces

                                Rectangle {
                                    id: workspace
                                    required property var modelData

                                    opacity: workspace.modelData.active ? 1 : 0.6
                                    color: "#1a1b26"
                                    radius: 999
                                    implicitWidth: columnBar.implicitWidth
                                    implicitHeight: workspaceText.implicitHeight + 20

                                    Text {
                                        id: workspaceText
                                        text: "%1".arg(workspace.modelData.name)
                                        color: "#ffffff"
                                        anchors.centerIn: parent
                                        font.bold: true
                                        font.pointSize: 10
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.preferredWidth: battery.width
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
