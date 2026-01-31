import QtQuick
import Quickshell
import Quickshell.Io

import qs.common
import qs.common.colors
import qs.common.components
import qs.widgets.ColorPaletteViewer

Rectangle {
    id: root
    height: Appearance.barWidgetHeight
    width: Appearance.barWidgetHeight
    radius: Appearance.barWidgetHeight
    color: Dynamic.color.primary

    MaterialIcon {
      icon: "settings"
    }

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
