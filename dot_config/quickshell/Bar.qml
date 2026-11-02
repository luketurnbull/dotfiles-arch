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
            implicitWidth: columnContainer.implicitWidth + 4

            anchors {
                top: true
                bottom: true
                right: true
            }

            Item {
                id: columnContainer
                implicitWidth: columnBar.implicitWidth + 2
                height: parent.height - 20
                anchors.right: parent.right

                ColumnLayout {
                    id: columnBar
                    property real rows: 3

                    implicitWidth: SidebarState.expanded ? 120 : 30
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
                            color: "#ee0a0a0a"
                        }
                    }

                    Rectangle {
                        id: middleContainer
                        color: "transparent"
                        Layout.preferredHeight: parent.height / columnBar.rows
                        Layout.preferredWidth: parent.width

                        ColumnLayout {
                            id: workspaces
                            spacing: 2
                            anchors.right: middleContainer.right

                            Repeater {
                                model: Hyprland.workspaces

                                Rectangle {
                                    id: workspace
                                    required property var modelData

                                    opacity: workspace.modelData.active ? 1 : 0.6
                                    color: "#0a0a0a"
                                    radius: 999
                                    implicitWidth: columnBar.implicitWidth
                                    implicitHeight: workspaceText.implicitHeight + 5

                                    Text {
                                        id: workspaceText
                                        text: "%1".arg(workspace.modelData.name)
                                        color: "#ededed"
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
                            color: "#ee0a0a0a"
                            anchors.bottom: parent.bottom
                        }
                    }
                }
            }
        }
    }
}
