import QtQuick

// Generic bar pill: rounded bottom, flat top (flush with screen edge).
Rectangle {
    id: pill

    required property string text
    property color textColor: "#ededed"
    property real horizontalPadding: 20
    property real verticalPadding: 10

    antialiasing: true

    implicitWidth: pillText.implicitWidth + horizontalPadding
    implicitHeight: pillText.implicitHeight + verticalPadding

    radius: 999
    topLeftRadius: 0
    topRightRadius: 0

    Text {
        id: pillText
        text: pill.text
        color: pill.textColor
        anchors.centerIn: parent

        font.bold: true
        font.pointSize: 10
        font.capitalization: Font.AllUppercase
    }
}
