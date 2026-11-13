pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string time: {
        Qt.formatDateTime(clock.date, "hh:mm");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes // seconds not displayed — per quickshell docs, Minutes improves battery life
    }
}
