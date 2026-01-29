import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Wayland

import "root:///scripts/fuzzySort.js" as FuzzySort
import qs.common
import qs.common.colors

Scope {
    id: root
    property bool shouldShow: false

    LazyLoader {
        active: root.shouldShow
        
        PanelWindow {
            WlrLayershell.namespace: 'AppLauncher'
            implicitHeight: screen.height
            implicitWidth: screen.width
            color: 'transparent'
            focusable: true
            
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.shouldShow = false;
                }
            }
            
            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: Appearance.barHeight + Appearance.barMargin + 10
                anchors.horizontalCenter: parent.horizontalCenter
                implicitHeight: 224  // 256 - 32
                implicitWidth: 512
                color: Dynamic.color.surface_container_lowest
                radius: 20  // Appearance.barHeight / 2 = 20
                border.color: Dynamic.color.surface_container_highest
                border.width: 2

                Rectangle {
                    implicitHeight: parent.height - 16  // containerPadding
                    implicitWidth: parent.width - 16
                    anchors.centerIn: parent
                    radius: 15  // radius * 1.5 = 15
                    color: Dynamic.color.surface_container
                    
                    ColumnLayout {
                        id: columnHolder
                        width: parent.width
                        height: parent.height
                        spacing: Appearance.universalSpacing
                        anchors.top: parent.top
                        
                        Rectangle {
                            id: search
                            anchors.top: parent.top
                            anchors.topMargin: 8
                            implicitHeight: 38
                            radius: 10  // defaultRadius
                            implicitWidth: parent.width - 16
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: Dynamic.color.surface_container_highest
                            
                            TextInput {
                                id: entry
                                focus: true
                                anchors.verticalCenter: parent.verticalCenter
                                font.family: Appearance.fontFamily
                                font.pixelSize: 16
                                color: Dynamic.color.primary
                                x: 8
                                property bool notSearching: text.length === 0
                                property string content: entry.text
                                property var current: appView.currentIndex
                                
                                onTextChanged: appView.forceLayout()
                                
                                Keys.onReturnPressed: {
                                    const list = appView.model;
                                    if (!notSearching && list.length > 0) {
                                        list[current].execute();
                                        root.shouldShow = false;
                                    } else if (notSearching && list.length > 0) {
                                        list[current].execute();
                                        root.shouldShow = false;
                                    }
                                }
                                
                                Keys.onDownPressed: {
                                    appView.incrementCurrentIndex()
                                }
                                
                                Keys.onUpPressed: {
                                    appView.decrementCurrentIndex()
                                }
                                
                                Keys.onEscapePressed: root.shouldShow = false
                                
                                Text {
                                    font.family: Appearance.fontFamily
                                    color: Dynamic.color.primary
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: 'Search for something..'
                                    visible: entry.notSearching
                                }
                            }
                        }
                        
                        Rectangle {
                            id: appList
                            anchors.top: search.bottom
                            anchors.topMargin: 8
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: appView.bottom
                            anchors.bottomMargin: 8
                            implicitHeight: appView.height + 16
                            radius: 10
                            color: Dynamic.color.surface_container_high
                            implicitWidth: parent.width - 16

                            ListView {
                                focus: true
                                id: appView
                                width: parent.width - 16
                                height: 128
                                model: entry.notSearching ? DesktopEntries.applications : FuzzySort.go(entry.text, DesktopEntries.applications.values, { all: true, keys: ["name", "genericName"] }).map(a => a.obj)
                                y: 8
                                spacing: 8
                                anchors.horizontalCenter: parent.horizontalCenter
                                clip: true

                                delegate: Rectangle {
                                    id: delegated
                                    property bool isSelected: ListView.isCurrentItem
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: parent.width
                                    height: 32
                                    color: Dynamic.color.surface_container_highest
                                    radius: 6.67  // radius / 1.5

                                    states: [
                                        State {
                                            name: "selected"
                                            when: delegated.isSelected

                                            PropertyChanges {
                                                target: delegated
                                                color: Dynamic.color.primary
                                            }
                                            PropertyChanges {
                                                target: text 
                                                color: Dynamic.color.surface_container_highest
                                                x: 8
                                                weight: 900
                                                textWidth: 120
                                            }
                                        }
                                    ]

                                    transitions: [
                                        Transition {
                                            from: ""; to: "selected"
                                            reversible: true
                                            ColorAnimation {
                                                properties: "color"
                                                duration: 300
                                                easing.type: Easing.OutQuad
                                            }
                                            NumberAnimation {
                                                properties: "x, weight, textWidth"
                                                duration: 300
                                                easing.type: Easing.OutQuad
                                            }
                                        }
                                    ]

                                    Text {
                                        id: text
                                        anchors.verticalCenter: parent.verticalCenter
                                        x: 4
                                        font.variableAxes: {
                                            "wght": weight,
                                            "wdth": textWidth
                                        }
                                        font.family: Appearance.fontFamily
                                        property int weight: 500
                                        property int textWidth: 100
                                        font.pointSize: 12
                                        text: modelData.name
                                        color: Dynamic.color.primary
                                    }
                                    
                                    MouseArea {
                                        id: handler
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: {
                                            modelData.execute()
                                            root.shouldShow = false
                                        }
                                        onEntered: {
                                            appView.currentIndex = index
                                        }
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

        function open(): void { root.shouldShow = true }
        function close(): void { root.shouldShow = false }
        function toggle(): void { root.shouldShow = !root.shouldShow }
    }
}