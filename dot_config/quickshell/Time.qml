// Time.qml

pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd d MMM H:mm AP");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
