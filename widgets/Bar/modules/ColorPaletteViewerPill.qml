import QtQuick
import Quickshell
import Quickshell.Io
import qs.common.components
import qs.widgets.ColorPaletteViewer

Pill {
    id: root
    icon: "\ue871"
    pillText: "Palette"
  
    Process {
        id: ipcProcess
        command: ["qs", "-c", "caylx", "ipc", "call", "ColorPaletteViewer", "toggle"]
    }
    
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
              ipcProcess.running = true
        }
    }
}
