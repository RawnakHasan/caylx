pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import qs.common

Scope {
    id: root

    property string wallpaperDir: Directories.wallpaperDirPath
    property string searchQuery: ""
    property var wallpaperList: []
    property var filteredWallpaperList: {
        if (searchQuery === "") return wallpaperList;

        return wallpaperList.filter((path) => {
            const filename = path.split('/').pop();
            return filename.toLowerCase().includes(searchQuery.toLowerCase());
        });
    }

    Process {
        workingDirectory: root.wallpaperDir
        command: ["sh", "-c", `find -L ${root.wallpaperDir} -type d -path */.* -prune -o -not -name .* -type f -print`]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const wallList = text.trim().split('\n').filter((path) => {
                    return path.length > 0;
                });
                root.wallpaperList = wallList;
            }
        }

    }

    FloatingWindow {
        id: mainWindow
        color: "#1a1a1a"
        implicitWidth: 800
        implicitHeight: 600
        visible: false

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12

            TextField {
                id: searchField

                Layout.fillWidth: true
                Layout.preferredHeight: 45
                placeholderText: "Search wallpapers..."
                text: root.searchQuery
                font.pixelSize: 16
                focus: true
                onTextChanged: {
                    root.searchQuery = text;
                    if (pathView.count > 0)
                        pathView.currentIndex = 0;

                }
                Keys.onDownPressed: pathView.focus = true
                Keys.onEscapePressed: Qt.quit()
            }

            PathView {
                id: pathView

                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: root.filteredWallpaperList
                pathItemCount: 7
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                        Quickshell.execDetached({
                            "command": ["sh", "-c", `/home/rawnak/.config/quickshell/ii/scripts/colors/switchwall.sh ${model[currentIndex]}`]
                        });

                    if (event.key === Qt.Key_Up)
                        decrementCurrentIndex();

                    if (event.key === Qt.Key_Down)
                        incrementCurrentIndex();

                    if (event.key === Qt.Key_Tab)
                        searchField.focus = true;

                    if (event.key === Qt.Key_Escape)
                        Qt.quit();

                }

                delegate: Item {
                    id: delegateItem

                    required property var modelData
                    required property int index

                    width: 400
                    implicitHeight: 300
                    scale: PathView.scale
                    z: PathView.z

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 10
                        color: "#2a2a2a"
                        radius: 8
                        border.color: pathView.currentIndex === delegateItem.index ? "#4a9eff" : "transparent"
                        border.width: 3

                        Image {
                            anchors.fill: parent
                            anchors.margins: 3
                            source: "file://" + delegateItem.modelData
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                            smooth: true

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.margins: 8
                                text: delegateItem.modelData.split('/').pop()
                                color: "white"
                                font.pixelSize: 12
                                elide: Text.ElideMiddle
                                style: Text.Outline
                                styleColor: "black"
                            }

                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                pathView.currentIndex = delegateItem.index;
                                Quickshell.execDetached({
                                    "command": ["sh", "-c", `/home/rawnak/.config/quickshell/ii/scripts/colors/switchwall.sh ${delegateItem.modelData}`]
                                });
                            }
                        }

                    }

                }

                path: Path {
                    startX: pathView.width / 2
                    startY: -100

                    PathAttribute {
                        name: "z"
                        value: 0
                    }

                    PathAttribute {
                        name: "scale"
                        value: 0.6
                    }

                    PathLine {
                        x: pathView.width / 2
                        y: pathView.height / 2
                    }

                    PathAttribute {
                        name: "z"
                        value: 10
                    }

                    PathAttribute {
                        name: "scale"
                        value: 1
                    }

                    PathLine {
                        x: pathView.width / 2
                        y: pathView.height + 100
                    }

                    PathAttribute {
                        name: "z"
                        value: 0
                    }

                    PathAttribute {
                        name: "scale"
                        value: 0.6
                    }

                }

            }

        }

    }

    IpcHandler {
        target: "WallpaperSelector"

        function open(): void { mainWindow.visible = true }
        function close(): void { mainWindow.visible = false }
        function toggle(): void { mainWindow.visible = !mainWindow.visible }
    }
}