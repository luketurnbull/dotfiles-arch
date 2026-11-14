import QtQuick
import Quickshell.Io
import Quickshell.Services.UPower

BarMenu {
    id: root
    menuName: "battery"

    readonly property var dev: UPower.displayDevice
    readonly property bool charging: dev.state === UPowerDeviceState.Charging
    readonly property real timeSecs: charging ? dev.timeToFull : dev.timeToEmpty

    function formatTime(seconds) {
        if (seconds <= 0) return "—";
        const h = Math.floor(seconds / 3600);
        const m = Math.round((seconds % 3600) / 60);
        return (h > 0 ? h + "H " : "") + m + "M";
    }

    StyledText { text: "BAT  " + Math.round(root.dev.percentage * 100) + "%" + (root.charging ? "  CHG" : "") }
    // healthPercentage is 0–100 (raw UPower Capacity). If displayDevice
    // reports N/A here, iterate UPower.devices for isLaptopBattery instead.
    StyledText { text: "HEALTH  " + (root.dev.healthSupported && root.dev.healthPercentage > 0 ? Math.round(root.dev.healthPercentage) + "%" : "N/A") }
    StyledText { text: (root.charging ? "FULL IN  " : "LEFT  ") + root.formatTime(root.timeSecs) }
    StyledText { text: "RATE  " + Math.abs(root.dev.changeRate).toFixed(1) + "W" }
    StyledText { text: "CPU  " + (SysStats.cpuReady ? Math.round(SysStats.cpuUsage * 100) + "%" : "--") }
    StyledText { text: "RAM  " + Math.round(SysStats.memUsage * 100) + "%  " + (SysStats.memUsedKb / 1048576).toFixed(1) + "/" + (SysStats.memTotalKb / 1048576).toFixed(1) + "G" }

    StyledText {
        text: "HTOP →"
        color: Theme.accent
        MouseArea {
            anchors.fill: parent
            onClicked: { htopProc.running = true; MenuState.close(); }
        }
    }

    Process { id: htopProc; command: ["ghostty", "-e", "htop"] }
}
