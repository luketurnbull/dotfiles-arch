import QtQuick

Rectangle {
    property string textColor: "#ededed"

    color: "transparent"
    radius: 999

    implicitWidth: timeText.width + 20
    implicitHeight: timeText.height + 10
    anchors.horizontalCenter: parent.horizontalCenter

    Text {
        id: timeText
        text: Time.time

        color: textColor
        anchors.centerIn: parent

        font.bold: true
        font.pointSize: 10
        font.capitalization: Font.AllUppercase
    }
}
