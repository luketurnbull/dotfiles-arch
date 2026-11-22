import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWin

            required property var modelData

            screen: modelData
            color: "transparent"

            // Strip height is content-driven, never hardcoded. The window
            // reserves popoutMaxHeight below the strip for the morph popout
            // (invisible, click-through via mask). Setting exclusiveZone
            // implies ExclusionMode.Normal — Auto would reserve the full
            // window height and push tiled windows down.
            readonly property real stripHeight: Math.max(workspaces.y + workspaces.implicitHeight, clock.implicitHeight, batteryPill.implicitHeight)

            implicitHeight: stripHeight + Appearance.popoutMaxHeight

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: 0
                left: Appearance.barMargin
                right: Appearance.barMargin
            }

            exclusiveZone: stripHeight

            // Input only on the strip + the open popout; everything else in
            // the reserved area is click-through.
            mask: Region {
                Region {
                    x: 0
                    y: 0
                    width: barWin.width
                    height: barWin.stripHeight
                }
                Region {
                    item: popout
                }
            }

            // --- Popout state: hover (per screen) + pinned (keyboard, global) ---

            PopoutState {
                id: popoutState
            }

            readonly property bool onFocusedScreen: !!Hyprland.focusedMonitor && Hyprland.focusedMonitor.name === modelData.name

            // popout name → pill item, for centering + keyboard lookup.
            readonly property var popoutPills: ({
                    "clock": clock,
                    "battery": batteryPill
                })
            readonly property string pinnedPopout: onFocusedScreen && popoutPills[MenuState.openMenu] ? MenuState.openMenu : ""

            function pillCenter(item) {
                return item.mapToItem(barWin.contentItem, item.width / 2, 0).x;
            }

            function openPopout(name, pill) {
                popoutState.currentName = name;
                popoutState.currentCenter = pillCenter(pill);
                popoutState.hasCurrent = true;
            }

            // Close on leave, delayed (hover intent) so the pointer can cross
            // pill → popout or pill → pill without a close/reopen flicker.
            readonly property bool anyPopoutHover: clockHover.containsMouse || batteryHover.containsMouse || popout.hovered

            onAnyPopoutHoverChanged: {
                if (anyPopoutHover)
                    popoutCloseTimer.stop();
                else
                    popoutCloseTimer.restart();
            }

            Timer {
                id: popoutCloseTimer
                interval: Appearance.popoutCloseDelay
                onTriggered: popoutState.hasCurrent = false
            }

            // Keyboard: grab focus only while pinned (a hidden always-mapped
            // window must never hold focus). Esc closes; click-outside closes.
            WlrLayershell.keyboardFocus: popout.pinned ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            Item {
                id: keySink
                focus: popout.pinned
                Keys.onEscapePressed: MenuState.close()
            }

            HyprlandFocusGrab {
                active: popout.pinned
                windows: [barWin]
                onCleared: MenuState.close()
            }

            // --- Bar content ---

            Workspaces {
                id: workspaces
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.left: parent.left
            }

            Rectangle {
                id: clock
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                color: Theme.bg
                radius: height / 2
                topLeftRadius: 0
                topRightRadius: 0
                implicitWidth: clockContent.implicitWidth + 40
                implicitHeight: clockContent.implicitHeight + 8

                ClockWidget {
                    id: clockContent
                    anchors.centerIn: parent
                }

                MouseArea {
                    id: clockHover
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: barWin.openPopout("clock", clock)
                    onClicked: MenuState.toggle("clock")
                }
            }

            Rectangle {
                id: batteryPill
                anchors.top: parent.top
                anchors.right: parent.right

                color: Theme.bg
                radius: height / 2
                topLeftRadius: 0
                topRightRadius: 0
                implicitWidth: batteryWidget.implicitWidth + 40
                implicitHeight: batteryWidget.implicitHeight + 8

                BatteryWidget {
                    id: batteryWidget
                    anchors.centerIn: parent
                }

                MouseArea {
                    id: batteryHover
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: barWin.openPopout("battery", batteryPill)
                    onClicked: MenuState.toggle("battery")
                }
            }

            // --- Morph popout (dummy content for now) ---

            MorphPopout {
                id: popout

                anchors.top: parent.top
                anchors.topMargin: barWin.stripHeight

                hoverState: popoutState
                pinnedName: barWin.pinnedPopout
                pinnedCenter: barWin.pinnedPopout ? barWin.pillCenter(barWin.popoutPills[barWin.pinnedPopout]) : 0

                PopoutLoader {
                    name: "clock"
                    popout: popout
                    sourceComponent: Rectangle {
                        implicitWidth: 300
                        implicitHeight: 220
                        radius: 8
                        color: Theme.accent

                        StyledText {
                            anchors.centerIn: parent
                            text: "clock popout"
                        }
                    }
                }

                PopoutLoader {
                    name: "battery"
                    popout: popout
                    sourceComponent: Rectangle {
                        implicitWidth: 220
                        implicitHeight: 150
                        radius: 8
                        color: Theme.warn

                        StyledText {
                            anchors.centerIn: parent
                            text: "battery popout"
                        }
                    }
                }
            }
        }
    }
}
