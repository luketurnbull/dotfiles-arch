import QtQuick
import Quickshell
import Quickshell.Services.UPower

// Full-height stats sidebar, one per screen (only the focused screen's opens).
// Keeps menuName "battery" so the quickshell:batterymenu shortcut (ALT+B) and
// hyprland bind stay untouched.
Scope {
    Variants {
        model: Quickshell.screens

        Sidebar {
            id: sidebar

            required property var modelData

            screen: modelData
            screenName: modelData.name
            menuName: "battery"

            readonly property var dev: UPower.displayDevice

            Row {
                spacing: 12

                RingGauge {
                    label: "CPU"
                    value: SysStats.cpuReady ? SysStats.cpuUsage : 0
                    centerText: SysStats.cpuReady ? Math.round(SysStats.cpuUsage * 100) + "%" : "--"
                }
                RingGauge {
                    label: "RAM"
                    value: SysStats.memUsage
                }
                RingGauge {
                    label: "BAT"
                    value: sidebar.dev.percentage
                }
            }
        }
    }
}
