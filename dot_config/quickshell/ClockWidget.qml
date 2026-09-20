import QtQuick

Rectangle {
    property real marginX: 20
    property real marginY: 8

    implicitWidth: timeText.implicitWidth + marginX * 2
    implicitHeight: timeText.implicitHeight + marginY * 2

    anchors.centerIn: parent
    color: "#ee1a1b26"
    radius: 999

    Text {
        id: timeText
        text: Time.time

        anchors.centerIn: parent
        color: "#ffffff"

        font.bold: true
        font.pointSize: 10
        font.capitalization: Font.AllUppercase
    }
}
