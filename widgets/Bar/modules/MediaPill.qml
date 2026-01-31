import Quickshell.Services.Mpris
import QtQuick

import qs.common.colors

Rectangle {
  height: 25
  width: 80
  radius: 25 / 2
  color: Dynamic.color.primary

  Component.onCompleted: {
    console.log(MprisPlayer.trackTitle)
  }

  Text {
    text: MprisPlayer.trackTitle || "Unknown Title"
    color: Dynamic.color.on_primary
  }
}