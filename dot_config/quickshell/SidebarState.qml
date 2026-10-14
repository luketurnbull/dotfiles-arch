pragma Singleton

import Quickshell

Singleton {
    id: root
    property bool expanded: false

    function toggle(): void {
        root.expanded = !root.expanded;
    }
}
