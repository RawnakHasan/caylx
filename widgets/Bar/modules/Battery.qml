import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.common.components
import qs.common
import qs.common.colors

Pill {
    id: root

    property bool isChargin: true

    icon: root.isChargin ? "bolt" : "battery_android_full"
    pillText: "100"
    pillTextBold: true
}