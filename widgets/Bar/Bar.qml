import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
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

    // ───────────────────────── Left Container ─────────────────────────
    Rectangle {
        id: leftContainer
        color: Dynamic.color.background
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: leftContent.width + (Appearance.barMargin * 2)
        height: Appearance.barHeight
        radius: Appearance.barHeight / 2
    }

    RowLayout {
        id: leftContent
        anchors.left: leftContainer.left
        anchors.leftMargin: Appearance.barMargin
        anchors.verticalCenter: leftContainer.verticalCenter
        spacing: Appearance.universalSpacing

        // ColorPaletteViewerPill { iconSize: 18 }
        Workspaces { }
    }

    // ───────────────────────── Center Container ─────────────────────────
    Rectangle {
        id: centerContainer
        color: Dynamic.color.background
        anchors.centerIn: parent
        implicitWidth: Appearance.barWidth
        implicitHeight: Appearance.barHeight
        radius: Appearance.barHeight / 2
    }

    // Left side of center
    RowLayout {
        anchors.left: centerContainer.left
        anchors.leftMargin: Appearance.barMargin
        anchors.verticalCenter: centerContainer.verticalCenter
        spacing: Appearance.universalSpacing

        AppLauncherButton { }
        ActiveTitlePill { }
    }

    // Center of center
    RowLayout {
        anchors.centerIn: centerContainer
        spacing: Appearance.universalSpacing

        ClockPill { }
    }

    // Right side of center
    RowLayout {
        anchors.right: centerContainer.right
        anchors.rightMargin: Appearance.barMargin
        anchors.verticalCenter: centerContainer.verticalCenter
        spacing: Appearance.universalSpacing

        CpuPill { }
        MemPill { }
    }

    // ───────────────────────── Right Container ─────────────────────────
    Rectangle {
        id: rightContainer
        color: Dynamic.color.background
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: rightContent.width + (Appearance.barMargin * 2)
        height: Appearance.barHeight
        radius: Appearance.barHeight / 2
    }

    RowLayout {
        id: rightContent
        anchors.right: rightContainer.right
        anchors.rightMargin: Appearance.barMargin
        anchors.verticalCenter: rightContainer.verticalCenter
        spacing: Appearance.universalSpacing

        MediaPill { }
        // Gif { }
        // BrightnessPill { }
        VolumePill { }
        Battery { }
        SettingsButton { }
        // add more right-side modules here
    }

    // ───────────────────────── IPC ─────────────────────────
    IpcHandler {
        target: "Bar"
        function open(): void { root.visible = true }
        function close(): void { root.visible = false }
        function toggle(): void { root.visible = !root.visible }
    }
}

