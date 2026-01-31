import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.common.colors
import qs.common

Rectangle {
    implicitHeight: 25
    implicitWidth: 10 * 25 + 5 * 9 + 25
    color: "transparent"
    radius: 25
    
    property list<string> jpNumbers: [ "一", "二", "三", "四", "五", "六", "七", "八", "九", "〇" ]
    
    RowLayout {
        anchors.fill: parent
        spacing: 5
        
        Repeater {
            model: 10
            
            Rectangle {
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                
                id: workspaceNumbers
                implicitWidth: isActive ? 50 : 25
                implicitHeight: 25
                radius: 25
                color: isActive ? Dynamic.color.primary : Dynamic.color.secondary_container
                
                // Animate width changes
                Behavior on implicitWidth {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
                
                // Animate color changes
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
                
                // Scale animation on click
                scale: mouseArea.pressed ? 0.9 : 1.0
                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.OutCubic
                    }
                }
                
                Text {
                    font.family: Appearance.fontFamily
                    font.bold: true
                    color: isActive ? Dynamic.color.on_primary : (ws ? Dynamic.color.on_primary_container : Dynamic.color.on_secondary_container)
                    anchors.centerIn: parent
                    bottomPadding: 1
                    rightPadding: 1
                    text: jpNumbers[index]
                    
                    // Animate text color changes
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                    }
                    
                    // Optional: scale text slightly when active
                    scale: workspaceNumbers.isActive ? 1.05 : 1.0
                    Behavior on scale {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                    }
                }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                    
                    // Optional: cursor change on hover
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}