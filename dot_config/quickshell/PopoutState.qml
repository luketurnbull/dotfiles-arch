import QtQuick

// Hover-driven popout state, one per bar instance (per screen). Keyboard
// (pinned) state is global in MenuState; MorphPopout merges the two.
QtObject {
    property string currentName
    property real currentCenter
    property bool hasCurrent
}
