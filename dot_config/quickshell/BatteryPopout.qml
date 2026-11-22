import QtQuick
import Quickshell.Services.UPower

// Battery details popout (morph target for the battery pill). Reads
// UPower.displayDevice directly — event-driven over DBus, no polling.
Column {
    id: root

    spacing: 6

    readonly property var dev: UPower.displayDevice
    readonly property real percentage: dev.percentage
    readonly property bool charging: dev.state === UPowerDeviceState.Charging

    function formatSeconds(s) {
        const day = Math.floor(s / 86400);
        const hr = Math.floor(s / 3600) % 24;
        const min = Math.floor(s / 60) % 60;

        const comps = [];
        if (day > 0)
            comps.push(day + "d");
        if (hr > 0)
            comps.push(hr + "h");
        if (min > 0)
            comps.push(min + "min");
        return comps.join(" ");
    }

    function statusText() {
        if (!dev.isLaptopBattery)
            return "No battery detected";
        if (UPower.onBattery) {
            const t = formatSeconds(dev.timeToEmpty);
            return t ? "Time remaining: " + t : "Calculating...";
        }
        if (dev.timeToFull > 0)
            return "Time until charged: " + formatSeconds(dev.timeToFull);
        if (Math.round(percentage * 100) === 100)
            return "Fully charged";
        return "Calculating...";
    }

    Row {
        spacing: 8

        BatteryWidget {
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 16
        }
        StyledText {
            anchors.verticalCenter: parent.verticalCenter
            text: Math.round(root.percentage * 100) + "%"
            font.pointSize: 16
        }
    }

    StyledText {
        text: root.statusText()
    }

    StyledText {
        opacity: 0.6
        // healthPercentage is raw 0–100 (UPower Capacity), unlike percentage.
        text: "Health " + Math.round(root.dev.healthPercentage) + "%" + (root.dev.changeRate > 0 ? " · " + root.dev.changeRate.toFixed(1) + " W" : "")
    }
}
