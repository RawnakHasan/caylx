import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

import qs.common.colors
import qs.common

Scope {
    id: root

    property bool shouldShowOsd: false

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

    // The OSD window will be created and destroyed based on shouldShowOsd.
    // PanelWindow.visible could be set instead of using a loader, but using
    // a loader will reduce the memory overhead when the window isn't open.
    LazyLoader {
        active: root.shouldShowOsd

        PanelWindow {
            // Since the panel's screen is unset, it will be picked by the compositor
            // when the window is created. Most compositors pick the current active monitor.

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
                        text: Pipewire.defaultAudioSink.audio.muted ? "volume_off" : "volume_up"
                        font.family: Appearance.iconFont
                        color: Dynamic.color.primary
                        font.pixelSize: 32 
                    }

                    ColumnLayout {
                        Layout.fillWidth: true

                        RowLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter // Centers the entire row vertically

                            Text {
                                text: "Volume"
                                color: Dynamic.color.primary
                                Layout.fillWidth: true // Pushes the second text to the right
                            }

                            Text {
                                text: Math.floor(Pipewire.defaultAudioSink.audio.volume * 100)
                                color: Dynamic.color.primary
                            }

                        }

                        Rectangle {
                            // Stretches to fill all left-over space
                            Layout.fillWidth: true
                            implicitHeight: 10
                            radius: 20
                            color: Dynamic.color.primary_container

                            Rectangle {
                                color: Dynamic.color.primary
                                implicitWidth: parent.width * Math.min(Pipewire.defaultAudioSink.audio.volume ?? 0, 1)
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

            // An empty click mask prevents the window from blocking mouse events.
            mask: Region {
            }

        }

    }

}