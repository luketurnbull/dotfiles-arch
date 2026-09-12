import Quickshell
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            color: "transparent"
            implicitHeight: clockContainer.implicitHeight + 5
            implicitWidth: clockContainer.implicitWidth

            Rectangle {
                id: clockContainer
                property real marginX: 20
                property real marginY: 10
                anchors.centerIn: parent

                implicitWidth: clock.implicitWidth + marginX * 2
                implicitHeight: clock.implicitHeight + marginY * 2
                color: "#ee1a1b26"
                radius: 999

                ClockWidget {
                    id: clock
                    anchors.centerIn: parent
                }
            }
        }
    }
}
