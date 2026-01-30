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
    
    // Left Container //
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
        anchors.left: parent.left
        anchors.leftMargin: Appearance.barMargin
        anchors.verticalCenter: parent.verticalCenter
        spacing: Appearance.universalSpacing
        
        // Modules
        ColorPaletteViewerPill { iconSize: 18 }
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
    
    // Right Container //
    Rectangle {
        id: rightContainer
        color: Dynamic.color.background
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: rightContent.width + (Appearance.barMargin * 2)
        height: Appearance.barHeight
        radius: Appearance.barHeight / 2
    }
    
    // Left Position For Center Container
    RowLayout {
        anchors.left: centerContainer.left
        anchors.leftMargin: Appearance.barMargin
        anchors.verticalCenter: centerContainer.verticalCenter
        spacing: Appearance.universalSpacing
        
        // Modules
        ActiveTitlePill { }
    }
    
    // Center Position For Center Container
    RowLayout {
        anchors.centerIn: centerContainer
        spacing: Appearance.universalSpacing
        
        // Modules
        ClockPill { }
    }
    
    // Right Position For Center Container
    RowLayout {
        id: rightContent
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
