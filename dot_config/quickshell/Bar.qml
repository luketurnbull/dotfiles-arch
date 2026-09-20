import Quickshell
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            readonly property real gap: 10

            screen: modelData

            margins.top: gap
            margins.right: gap
            margins.left: gap

            anchors {
                top: true
                left: true
                right: true
            }

            color: "transparent"
            implicitHeight: clock.implicitHeight

            ClockWidget {
                id: clock
            }

            BatteryWidget {
                id: battery
            }
        }
    }
}
