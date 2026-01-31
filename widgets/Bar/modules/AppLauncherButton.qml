import QtQuick
import Quickshell
import Quickshell.Io

import qs.common
import qs.common.functions
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
        icon: "rocket_launch"
        iconSize: 18
    }

    Process {
        id: ipcProcess
        command: ["qs", "-c", "caylx", "ipc", "call", "AppLauncher", "toggle"]
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            ipcProcess.running = true
        }
    }
}
