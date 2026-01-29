import QtQuick
import Quickshell.Hyprland
import qs.common.components
import qs.widgets.ColorPaletteViewer

Pill {
  id: root
  icon: "\ue871"
  pillText: "Palette"

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      Hyprland.dispatch("exec qs -c caylx ipc call 'Color Palette Viewer' toggle")
    }
  }
}