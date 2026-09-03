// Bar.qml
import Quickshell
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            anchors.top: true
            implicitHeight: container.height + 5
            implicitWidth: container.width
            color: "transparent"

            Rectangle {
                id: container
                property real margin: 10

                radius: 20
                anchors.bottom: parent.bottom
                implicitHeight: clock.height + margin * 2
                implicitWidth: clock.width + margin * 8
                color: "#000000"

                ClockWidget {
                    id: clock
                    anchors.centerIn: parent
                    color: "#ffffff"
                }
            }
        }
    }
}
