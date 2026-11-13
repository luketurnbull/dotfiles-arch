import QtQuick

// Center of the bar: clock + battery in one pill.
// Add future widgets to the Row. (Row top-aligns children by default —
// the verticalCenter anchors on each child are what center them.)
Pill {
    id: centerBlock

    property color colorWarning: "#ff4d42"

    verticalPadding: 12

    contentItem: contentRow

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: 8

        ClockWidget {
            anchors.verticalCenter: parent.verticalCenter
            color: centerBlock.textColor
        }

        BatteryWidget {
            anchors.verticalCenter: parent.verticalCenter
            colorNormal: centerBlock.textColor
            colorWarning: centerBlock.colorWarning
        }
    }
}
