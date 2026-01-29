import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Io

import qs.widgets.ColorPaletteViewer.modules
import qs.common.colors

FloatingWindow {
    id: root

    minimumSize {
        width: Screen.width * 3 / 4
        height: Screen.height * 3 / 4
    }

    title: "ColorPaletteViewer"
    visible: false
    color: Qt.rgba(Dynamic.color.background.r, Dynamic.color.background.g, Dynamic.color.background.b, 0.9)

    Swatches { }

    IpcHandler {
        target: "Color Palette Viewer"

        function open(): void { root.visible = true }
        function close(): void { root.visible = false }
        function toggle(): void { root.visible = !root.visible }
    }
}
