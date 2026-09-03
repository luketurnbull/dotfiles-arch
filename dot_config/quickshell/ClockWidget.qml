// ClockWidget.qml
import QtQuick

Text {
    text: Time.time
    font.bold: true
    font.capitalization: Font.AllUppercase
    font.pointSize: 10
    font.family: 'sans serif'
}
