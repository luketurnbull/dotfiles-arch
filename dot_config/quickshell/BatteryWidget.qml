import QtQuick
import Quickshell.Services.UPower

StyledText {
    id: batteryRoot

    property real percentage: UPower.displayDevice.percentage
    property bool charging: UPower.displayDevice.state === UPowerDeviceState.Charging

    // Nerd Font battery glyphs, low → full. v3+ codepoints; the charging set
    // interleaves the F089x block (10/50/70 → F089C/D/E), so both sets are
    // hardcoded. 10 entries each — index runs 0–9.
    readonly property var dischargingGlyphs: ["\u{F007A}", "\u{F007B}", "\u{F007C}", "\u{F007D}", "\u{F007E}", "\u{F007F}", "\u{F0080}", "\u{F0081}", "\u{F0082}", "\u{F0085}"]
    readonly property var chargingGlyphs: ["\u{F089C}", "\u{F0086}", "\u{F0087}", "\u{F0088}", "\u{F089D}", "\u{F0089}", "\u{F089E}", "\u{F008A}", "\u{F008B}", "\u{F0085}"]

    text: batteryRoot.getGlyph()
    color: batteryRoot.getTextColor()

    function getGlyph(): string {
        const index = Math.min(9, Math.floor(percentage * 10));
        return (charging ? chargingGlyphs : dischargingGlyphs)[index];
    }

    function isBatteryLow(): bool {
        return percentage < 0.15;
    }

    function getTextColor(): string {
        return isBatteryLow() ? Theme.warn : Theme.text;
    }
}
