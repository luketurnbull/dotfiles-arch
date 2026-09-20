import QtQuick
import Quickshell.Services.UPower

Rectangle {
    id: batteryRoot

    property real marginX: 20
    property real marginY: 8

    property real percentage: UPower.displayDevice.percentage

    property string colorWarning: "#ff0000"
    property string colorNormal: "#ffffff"

    implicitWidth: timeText.implicitWidth + marginX * 2
    implicitHeight: timeText.implicitHeight + marginY * 2

    anchors.right: parent.right

    color: "#ee1a1b26"
    radius: 999

    function isBatteryLow(): bool {
        return percentage < 0.15;
    }

    function getTextColor(): string {
        if (isBatteryLow()) {
            return colorWarning;
        }

        return colorNormal;
    }

    Text {
        id: timeText
        text: "%1 \%".arg(batteryRoot.percentage * 100)

        anchors.centerIn: parent
        color: batteryRoot.getTextColor()

        font.bold: true
        font.pointSize: 10
        font.capitalization: Font.AllUppercase
    }

    Connections {
        function onPercentageChanged(): void {
            if (!UPower.displayDevice.ready)
                return;

            batteryRoot.percentage = UPower.displayDevice.percentage;
        }

        target: UPower.displayDevice
    }
}
