import QtQuick

// Generic bar pill: rounded bottom, flat top (flush with screen edge).
// Default content is a Text label; override `contentItem` to host custom content.
Rectangle {
    id: pill

    property string text: ""
    property color textColor: "#ededed"
    property real horizontalPadding: 40
    property real verticalPadding: 10
    property real fontPointSize: 10

    property Item contentItem: pillText

    antialiasing: true

    implicitWidth: contentItem.implicitWidth + horizontalPadding
    implicitHeight: contentItem.implicitHeight + verticalPadding

    radius: 999
    topLeftRadius: 0
    topRightRadius: 0

    Text {
        id: pillText
        text: pill.text
        color: pill.textColor
        anchors.centerIn: parent

        font.bold: true
        font.pointSize: pill.fontPointSize
        font.capitalization: Font.AllUppercase
    }
}
