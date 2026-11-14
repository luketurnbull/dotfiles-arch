pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// CPU/RAM via FileView on /proc — no subprocesses, 2s poll.
Singleton {
    id: root

    property real cpuUsage: 0        // 0–1, valid only after 2nd sample
    property bool cpuReady: false
    property real memUsedKb: 0
    property real memTotalKb: 1
    readonly property real memUsage: memUsedKb / memTotalKb

    property var _prevCpu: null

    FileView {
        id: statFile
        path: "/proc/stat"
        onLoaded: root._parseStat(text())
    }

    FileView {
        id: memFile
        path: "/proc/meminfo"
        onLoaded: root._parseMem(text())
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: { statFile.reload(); memFile.reload(); }
    }

    function _parseMem(text) {
        const total = text.match(/MemTotal:\s*(\d+)/);
        const avail = text.match(/MemAvailable:\s*(\d+)/);  // NOT MemFree
        if (total && avail) {
            memTotalKb = Number(total[1]);
            memUsedKb = Number(total[1]) - Number(avail[1]);
        }
    }

    function _parseStat(text) {
        // Aggregate line: "cpu  user nice system idle iowait irq softirq"
        const m = text.match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/m);
        if (!m) return;
        const f = m.slice(1).map(Number);
        const total = f.reduce((a, b) => a + b, 0);
        const idle = f[3] + f[4];  // idle + iowait, same definition as top
        if (_prevCpu) {
            const dTotal = total - _prevCpu.total;
            const dIdle = idle - _prevCpu.idle;
            if (dTotal > 0) {
                cpuUsage = 1 - dIdle / dTotal;
                cpuReady = true;
            }
        }
        _prevCpu = { total, idle };
    }
}
