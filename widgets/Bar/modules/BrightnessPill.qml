import QtQuick
import Quickshell.Io
import qs.common.components
import qs.common.services

Pill {
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

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }
    
    icon: "light_mode"
    pillText: Math.floor((BrightnessService.currentBrightness / BrightnessService.maxBrightness) * 100)
    
    // Add MouseArea for click and scroll
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor

        // Scroll to adjust brightness
        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) {
                // Scroll up - increase brightness
                increaseProc.running = true;
            } else if (wheel.angleDelta.y < 0) {
                // Scroll down - decrease brightness
                decreaseProc.running = true;
            }
        }
    }
}