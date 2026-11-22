pragma ComponentBehavior: Bound

import QtQuick

// One named popout in a MorphPopout stack. Loads on the same frame it becomes
// current (so the container gets its size immediately), then fades in; fades
// out before unloading. That ordering is what makes container-resize +
// content-swap read as a single morph (caelestia's Content.qml pattern).
Loader {
    id: root

    required property string name
    // The owning MorphPopout (duck-typed: hasCurrent, currentName).
    required property var popout

    readonly property bool shouldBeActive: popout.hasCurrent && popout.currentName === name

    anchors.centerIn: parent

    active: false
    opacity: 0

    states: State {
        name: "active"
        when: root.shouldBeActive

        PropertyChanges {
            root.active: true
            root.opacity: 1
        }
    }

    transitions: [
        Transition {
            from: ""
            to: "active"

            SequentialAnimation {
                // Load first — size must exist on the same frame.
                PropertyAction {
                    property: "active"
                }
                EffectsAnim {
                    property: "opacity"
                }
            }
        },
        Transition {
            from: "active"
            to: ""

            SequentialAnimation {
                EffectsAnim {
                    property: "opacity"
                }
                PropertyAction {
                    property: "active"
                }
            }
        }
    ]
}
