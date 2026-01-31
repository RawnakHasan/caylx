import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "root:/scripts/fuzzySort.js" as FuzzySort

import qs.common
import qs.common.components
import qs.common.colors

Scope {
    id: root
    property bool isOpen: false
    
    PanelWindow {
        visible: root.isOpen
        focusable: true
        implicitWidth: 600
        implicitHeight: 500
        color: "transparent"
        
        onVisibleChanged: {
            if (visible) {
                input.text = ""
                input.forceActiveFocus()
                list.currentIndex = 0
            }
        }
        
        Rectangle {
            anchors.fill: parent
            anchors.margins: 20
            color: Dynamic.color.background
            radius: 20
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15
                
                // Search bar
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Appearance.barWidgetHeight
                    color: Dynamic.color.secondary_container
                    radius: Appearance.barWidgetHeight / 2
                    
                    RowLayout {
                        anchors.fill: parent
                        spacing: 0
                        
                        Rectangle {
                            Layout.preferredWidth: Appearance.barWidgetHeight * 2
                            Layout.preferredHeight: Appearance.barWidgetHeight
                            Layout.alignment: Qt.AlignLeft
                            color: Dynamic.color.primary
                            radius: Appearance.barWidgetHeight
                            
                            Text {
                                anchors.centerIn: parent
                                font.pixelSize: 20
                                color: Dynamic.color.on_primary
                                text: "search"
                                font.family: Appearance.iconFont
                            }
                        }
                        
                        TextInput {
                            id: input
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            Layout.leftMargin: 12
                            Layout.rightMargin: 12
                            focus: true
                            color: Dynamic.color.on_secondary_container
                            font.family: Appearance.fontFamily
                            font.pixelSize: 16
                            verticalAlignment: Text.AlignVCenter
                            selectByMouse: true
                            
                            Text {
                                visible: input.text.length === 0
                                text: "Search applications..."
                                color: Dynamic.color.on_secondary_container
                                opacity: 0.5
                                font: input.font
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            
                            Keys.onReturnPressed: {
                                if (list.count > 0 && list.currentIndex >= 0) {
                                    var item = list.model[list.currentIndex]
                                    if (item && item.execute) {
                                        item.execute()
                                        root.isOpen = false
                                    }
                                }
                            }
                            
                            Keys.onDownPressed: {
                                if (list.currentIndex < list.count - 1) {
                                    list.incrementCurrentIndex()
                                }
                            }
                            
                            Keys.onUpPressed: {
                                if (list.currentIndex > 0) {
                                    list.decrementCurrentIndex()
                                }
                            }
                            
                            Keys.onEscapePressed: root.isOpen = false
                        }
                    }
                }
                
                // Results area
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: Dynamic.color.surface
                    radius: 12
                    clip: true
                    
                    ListView {
                        id: list
                        anchors.fill: parent
                        anchors.margins: 5
                        spacing: 2
                        
                        model: {
                            if (input.text.length === 0) {
                                var apps = DesktopEntries.applications
                                return apps.values ? Array.from(apps.values) : apps
                            } else {
                                var apps = DesktopEntries.applications
                                var appArray = apps.values ? Array.from(apps.values) : apps
                                var results = FuzzySort.go(
                                    input.text,
                                    appArray,
                                    { keys: ["name", "genericName"], limit: 50 }
                                )
                                return results.map(a => a.obj)
                            }
                        }
                        
                        delegate: Rectangle {
                            required property var modelData
                            required property int index
                            
                            width: list.width
                            height: 50
                            color: list.currentIndex === index ? Dynamic.color.primary_container : "transparent"
                            radius: 8
                            
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                
                                onEntered: list.currentIndex = index
                                onClicked: {
                                    if (modelData && modelData.execute) {
                                        modelData.execute()
                                        root.isOpen = false
                                    }
                                }
                            }
                            
                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 15
                                anchors.rightMargin: 15
                                spacing: 15
                                
                                Item {
                                    Layout.preferredWidth: 36
                                    Layout.preferredHeight: 36
                                    
                                    // Try Papirus first
                                    Image {
                                        id: papirusIcon
                                        anchors.fill: parent
                                        source: {
                                            if (!modelData || !modelData.icon) return ""
                                            var iconName = modelData.icon
                                            // Extract just the icon name if it's a path
                                            if (iconName.includes("/")) {
                                                iconName = iconName.split("/").pop().replace(/\.(png|svg|xpm)$/, "")
                                            }
                                            return "file:///usr/share/icons/Papirus/48x48/apps/" + iconName + ".svg"
                                        }
                                        sourceSize.width: 36
                                        sourceSize.height: 36
                                        smooth: true
                                        asynchronous: false
                                        visible: status === Image.Ready
                                    }
                                    
                                    // Fallback to system icon
                                    Image {
                                        id: systemIcon
                                        anchors.fill: parent
                                        source: {
                                            if (!modelData || !modelData.icon) return ""
                                            var icon = modelData.icon
                                            if (icon.startsWith("/")) return "file://" + icon
                                            if (icon.startsWith("file://")) return icon
                                            return "image://icon/" + icon
                                        }
                                        sourceSize.width: 36
                                        sourceSize.height: 36
                                        smooth: true
                                        asynchronous: true
                                        visible: status === Image.Ready && papirusIcon.status !== Image.Ready
                                    }
                                    
                                    // Final fallback to letter
                                    Rectangle {
                                        anchors.fill: parent
                                        visible: papirusIcon.status !== Image.Ready && systemIcon.status !== Image.Ready
                                        color: Dynamic.color.primary
                                        radius: 8
                                        
                                        Text {
                                            anchors.centerIn: parent
                                            text: modelData && modelData.name ? modelData.name.charAt(0).toUpperCase() : "?"
                                            font.family: Appearance.fontFamily
                                            font.pixelSize: 20
                                            font.bold: true
                                            color: Dynamic.color.on_primary
                                        }
                                    }
                                }
                                
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 2
                                    
                                    Text {
                                        text: modelData ? modelData.name : ""
                                        font.family: Appearance.fontFamily
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: Dynamic.color.on_surface
                                        elide: Text.ElideRight
                                        Layout.fillWidth: true
                                    }
                                    
                                    Text {
                                        text: (modelData && modelData.genericName) ? modelData.genericName : ""
                                        font.family: Appearance.fontFamily
                                        font.pixelSize: 12
                                        color: Dynamic.color.on_surface
                                        opacity: 0.7
                                        elide: Text.ElideRight
                                        Layout.fillWidth: true
                                        visible: text.length > 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    IpcHandler {
        target: "AppLauncher"
        function open(): void { root.isOpen = true }
        function close(): void { root.isOpen = false }
        function toggle(): void { root.isOpen = !root.isOpen }
    }
}