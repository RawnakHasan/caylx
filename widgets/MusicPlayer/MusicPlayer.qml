import Quickshell
import Quickshell.Services.Mpris
import QtQuick

ShellRoot {
    property QtObject player: MprisPlayer


    PanelWindow {
        visible: false

        anchors {
            top: true
            left: true
        }

        width: 400
        height: 200

        Column {
            anchors.fill: parent

            Image {
                id: albumArt
                source: player?.metadata?.artUrl ?? ""
                width: 150
                height: 150
            }

            Text {
                text: player?.metadata?.title ?? "No title"
            }

            Text {
                text: player?.metadata?.artist ?? "No artist"
            }

            Text {
                text: player?.metadata?.album ?? "No album"
            }
        }
    }
}
