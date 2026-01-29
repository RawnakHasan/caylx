import QtQuick

import qs.common.components

Pill {
  id: root
  property string timeText: ""
  property string dateText: ""

  bubbleText: root.timeText
  pillText: root.dateText
  maxWidth: 200
  pillTextOffset: 40

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      const now = new Date()
      root.timeText = Qt.formatDateTime(now, "hh:mm A")
      root.dateText = Qt.formatDateTime(now, "ddd, dd/MM")
    }
  }

  Component.onCompleted: {
    const now = new Date()
    root.timeText = Qt.formatDateTime(now, "hh:mm A")
    root.dateText = Qt.formatDateTime(now, "ddd, dd/MM")
  }
}