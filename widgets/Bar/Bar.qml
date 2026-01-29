import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import qs.common
import qs.common.colors
import qs.widgets.Bar.modules

PanelWindow {
    id: root

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: Appearance.barHeight
    implicitWidth: Appearance.barWidth
    color: "transparent"
    visible: true

    margins {
        top: 5
        left: 5
        right: 5
    }

    // Center Container //
    Rectangle {
        id: centerContainer

        color: Dynamic.color.background
        anchors.centerIn: parent
        implicitWidth: Appearance.barWidth
        implicitHeight: Appearance.barHeight
        radius: Appearance.barHeight
    }

    // Left Container //
    Rectangle {
        id: leftContainer

        color: Dynamic.color.background
        anchors.left: parent.left
        width: 80
        height: 40
        radius: 50

        ColorPaletteViewerPill { iconSize: 18 }
    }

    // Right Container //
    Rectangle {
        id: rightContainer

        color: Dynamic.color.background
        anchors.right: parent.right
        width: 80
        height: 40
        radius: 50
    }

    // Center Position
    RowLayout {
        anchors.centerIn: centerContainer
        spacing: Appearance.universalSpacing

        // Modules
        // ClockWidget { }
        ClockPill { }
    }

    // Left Position
    RowLayout {
        anchors.left: centerContainer.left
        anchors.leftMargin: Appearance.barMargin
        anchors.verticalCenter: centerContainer.verticalCenter
        spacing: Appearance.universalSpacing

        // Modules
        ActiveTitlePill { }
    }

    // Right Position
    RowLayout {
        anchors.right: centerContainer.right
        anchors.rightMargin: Appearance.barMargin
        anchors.verticalCenter: centerContainer.verticalCenter
        spacing: Appearance.universalSpacing

        // Modules
        CpuPill { }
        MemPill { }
    }

    IpcHandler {
        target: "Bar"

        function open(): void { root.visible = true }
        function close(): void { root.visible = false }
        function toggle(): void { root.visible = !root.visible }
    }
}