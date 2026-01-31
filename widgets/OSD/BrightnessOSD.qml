import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.common.colors
import qs.common.services
import qs.common

Scope {
    id: root
    property bool shouldShowOsd: false
    
    // Watch for brightness changes
    Connections {
        target: BrightnessService
        function onCurrentBrightnessChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }
    
    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }
    
    // Process for increasing brightness
    Process {
        id: increaseProc
        command: ["brightnessctl", "set", "5%+"]
    }
    
    // Process for decreasing brightness
    Process {
        id: decreaseProc
        command: ["brightnessctl", "set", "5%-"]
    }
    
    // Helper functions to change brightness
    function increaseBrightness() {
        increaseProc.running = true;
    }
    
    function decreaseBrightness() {
        decreaseProc.running = true;
    }
    
    LazyLoader {
        active: root.shouldShowOsd
        
        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 5
            exclusiveZone: 0
            implicitWidth: 200
            implicitHeight: 50
            color: "transparent"
            
            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: Dynamic.color.background
                
                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 15
                        rightMargin: 20
                    }
                    
                    Text {
                        text: "light_mode"
                        font.family: Appearance.iconFont
                        color: Dynamic.color.primary
                        font.pixelSize: 32
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            
                            Text {
                                text: "Brightness"
                                color: Dynamic.color.primary
                                Layout.fillWidth: true
                            }
                            
                            Text {
                                text: Math.floor((BrightnessService.currentBrightness / BrightnessService.maxBrightness) * 100)
                                color: Dynamic.color.primary
                            }
                        }
                        
                        Rectangle {
                            Layout.fillWidth: true
                            implicitHeight: 10
                            radius: 20
                            color: Dynamic.color.primary_container
                            
                            Rectangle {
                                color: Dynamic.color.primary
                                implicitWidth: parent.width * Math.min(BrightnessService.currentBrightness / BrightnessService.maxBrightness, 1)
                                radius: parent.radius
                                anchors {
                                    left: parent.left
                                    top: parent.top
                                    bottom: parent.bottom
                                }
                            }
                        }
                    }
                }
            }
            
            mask: Region {}
        }
    }
}