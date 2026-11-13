import QtQuick
import Quickshell.Services.UPower

Pill {
    id: batteryRoot

    property real percentage: UPower.displayDevice.percentage

    property string colorWarning: "#ff4d42"
    property string colorNormal: "#ededed"

    text: "%1 \%".arg(batteryRoot.percentage * 100)
    textColor: batteryRoot.getTextColor()

    function isBatteryLow(): bool {
        return percentage < 0.15;
    }

    function getTextColor(): string {
        if (isBatteryLow()) {
            return colorWarning;
        }

        return colorNormal;
    }
}
