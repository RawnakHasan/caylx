import QtQuick
import Quickshell.Io

Item {
    id: systemModules    // lowercase id
    property int cpuUsage: 0
    property int memUsage: 0
    property int lastCpuTotal: 0
    property int lastCpuIdle: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var p = data.trim().split(/\s+/)
                var idle = parseInt(p[4]) + parseInt(p[5])
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                if (systemModules.lastCpuTotal > 0) {
                    systemModules.cpuUsage = Math.round(
                        100 * (1 - (idle - systemModules.lastCpuIdle) / (total - systemModules.lastCpuTotal))
                    )
                }
                systemModules.lastCpuTotal = total
                systemModules.lastCpuIdle = idle
            }
        }
    }

    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var total = parseInt(parts[1]) || 1
                var used = parseInt(parts[2]) || 0
                systemModules.memUsage = Math.round(100 * used / total)
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
        }
    }
}

