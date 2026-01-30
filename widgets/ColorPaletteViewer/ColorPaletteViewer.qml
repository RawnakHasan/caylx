import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Io

import qs.widgets.ColorPaletteViewer.modules
import qs.common.colors

FloatingWindow {
    id: root
    property bool isOpen: false

    minimumSize {
        width: Screen.width * 3 / 4
        height: Screen.height * 3 / 4
    }

    title: "ColorPaletteViewer"
    visible: isOpen
    color: Qt.rgba(Dynamic.color.background.r, Dynamic.color.background.g, Dynamic.color.background.b, 0.9)

    FocusScope {
        anchors.fill: parent
        focus: true
        
        Keys.onEscapePressed: root.isOpen = false
        
        Swatches { }
    }

    IpcHandler {
        target: "ColorPaletteViewer"

        function open(): void { root.isOpen = true }
        function close(): void { root.isOpen = false }
        function toggle(): void { root.isOpen = !root.isOpen }
    }
}
