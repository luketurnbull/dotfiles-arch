import QtQuick

Rectangle {
    color: "transparent"
    radius: 999

    implicitWidth: timeText.width + 20
    implicitHeight: timeText.height + 20
    anchors.horizontalCenter: parent.horizontalCenter

    Text {
        id: timeText
        text: Time.time

        color: "#ffffff"
        anchors.centerIn: parent

        font.bold: true
        font.pointSize: 10
        font.capitalization: Font.AllUppercase
    }
}
