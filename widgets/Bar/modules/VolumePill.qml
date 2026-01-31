import QtQuick
import Quickshell.Services.Pipewire
import qs.common.components

Pill {
    // Bind the pipewire node so its volume will be tracked
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    
    Connections {
        function onVolumeChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
        target: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio : null
    }
    
    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }
    
    icon: Pipewire.defaultAudioSink.audio.muted ? "volume_off" : "volume_up"
    pillText: Math.floor(Pipewire.defaultAudioSink.audio.volume * 100)
    
    // Add MouseArea for click and scroll
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
        
        // Click to toggle mute
        onClicked: {
            if (Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio) {
                Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted;
            }
        }
        
        // Scroll to adjust volume
        onWheel: (wheel) => {
            if (Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio) {
                var currentVolume = Pipewire.defaultAudioSink.audio.volume;
                var volumeChange = 0.05; // 5% change
                
                if (wheel.angleDelta.y > 0) {
                    // Scroll up - increase volume
                    Pipewire.defaultAudioSink.audio.volume = Math.min(1.0, currentVolume + volumeChange);
                } else if (wheel.angleDelta.y < 0) {
                    // Scroll down - decrease volume
                    Pipewire.defaultAudioSink.audio.volume = Math.max(0.0, currentVolume - volumeChange);
                }
            }
        }
    }
}