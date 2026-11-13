import QtQuick
import Quickshell
import Quickshell.Io

// Active-theme palette, read from ~/.config/themes/current/palette.json
// (written by theme-set). Defaults = noir, used if the file is missing/invalid.
QtObject {
    property string bg: "#ee0a0a0a"
    property string bgSolid: "#0a0a0a"
    property string text: "#ededed"
    property string accent: "#ff3b30"
    property string warn: "#ff4d42"
    // Active window border — mirrors hyprland.lua `active` per theme.
    property string border: "#444444"

    property FileView _file: FileView {
        path: Quickshell.env("HOME") + "/.config/themes/current/palette.json"
        watchChanges: true
        onFileChanged: reload()
        onLoaded: _apply()
        onLoadFailed: function() {} // keep defaults
    }

    function _apply() {
        try {
            const data = JSON.parse(_file.text());
            if (data.bg) bg = data.bg;
            if (data.bgSolid) bgSolid = data.bgSolid;
            if (data.text) text = data.text;
            if (data.accent) accent = data.accent;
            if (data.warn) warn = data.warn;
            if (data.border) border = data.border;
        } catch (e) {}
    }
}
