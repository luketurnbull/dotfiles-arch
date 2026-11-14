import QtQuick

// Ring gauge for a 0–1 value (CPU/RAM/battery), % in the middle, label below.
// Canvas-drawn: track ring + value arc, both round-capped.
// Track = Theme.text at low alpha — NEVER a palette color: some themes set
// accent == border, which merged track and value into a full circle.
Item {
    id: root

    property real value: 0 // 0–1
    property string label: ""
    property string centerText: Math.round(value * 100) + "%"
    property int size: 72
    property int lineWidth: 5

    implicitWidth: size
    implicitHeight: column.implicitHeight

    property real degree: Math.max(0, Math.min(1, value)) * 360

    Behavior on degree {
        NumberAnimation {
            duration: Appearance.durEnter
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.curveDecel
        }
    }

    Column {
        id: column
        spacing: 3

        Item {
            width: root.size
            height: root.size

            Canvas {
                id: canvas
                anchors.fill: parent

                onPaint: {
                    const ctx = getContext("2d");
                    ctx.reset();
                    const r = root.size / 2 - root.lineWidth / 2;
                    ctx.lineWidth = root.lineWidth;
                    ctx.lineCap = "round";

                    // track ring — dimmed text color (see header comment)
                    ctx.globalAlpha = 0.2;
                    ctx.beginPath();
                    ctx.arc(root.size / 2, root.size / 2, r, 0, 2 * Math.PI);
                    ctx.strokeStyle = Theme.text;
                    ctx.stroke();
                    ctx.globalAlpha = 1;

                    // value arc from 12 o'clock, clockwise (capped just under
                    // 360° — a closed arc would lose its round caps)
                    ctx.beginPath();
                    ctx.arc(root.size / 2, root.size / 2, r, -Math.PI / 2,
                            -Math.PI / 2 + Math.min(root.degree, 359.999) * Math.PI / 180);
                    ctx.strokeStyle = Theme.accent;
                    ctx.stroke();
                }

                onWidthChanged: requestPaint()
                onHeightChanged: requestPaint()

                Connections {
                    target: root
                    function onDegreeChanged() { canvas.requestPaint(); }
                }

                // Recolor live on theme-set switches.
                Connections {
                    target: Theme
                    function onAccentChanged() { canvas.requestPaint(); }
                    function onTextChanged() { canvas.requestPaint(); }
                }
            }

            StyledText {
                anchors.centerIn: parent
                text: root.centerText
            }
        }

        StyledText {
            text: root.label
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
