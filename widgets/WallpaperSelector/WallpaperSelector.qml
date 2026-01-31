pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Qt5Compat.GraphicalEffects 

import qs.common
import qs.common.colors

Scope {
	id: root

	property string wallpaperDir: Directories.wallpaperDirPath // e.g. -> "/home/quickshell-dev/Pictures/Wallpapers" // Change it to the absolute path to your Wallpaper dir
	property string searchQuery: ""
	property var wallpaperList: []
	
	// Array of folders to exclude (relative to wallpaperDir or absolute paths)
	property var excludedFolders: [
		"Arknights/Mobile",
		"Honkai-Star-Rail/Mobile",
		"Punishing-Gray-Raven/Mobile",
        "Vtubers/Mobile",
        "Wallpapers-Phone",
        "Wuthering-Waves/Mobile",
        "Zenless-Zone-Zero/Mobile"
		// Add more folder names or paths here
	]
	
	property var filteredWallpaperList: {
		if (searchQuery === "")
			return wallpaperList;
		return wallpaperList.filter(path => {
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
				const wallList = text.trim().split('\n').filter(path => {
					if (path.length === 0) return false;
					
					// Check if the path contains any excluded folder
					for (let i = 0; i < root.excludedFolders.length; i++) {
						const excludedFolder = root.excludedFolders[i];
						// Check if path contains the excluded folder as a path component
						if (path.includes('/' + excludedFolder + '/') || 
							path.endsWith('/' + excludedFolder)) {
							return false;
						}
					}
					return true;
				});
				root.wallpaperList = wallList;
			}
		}
	}

	FloatingWindow {
		title: "WallpaperSelector"
		id: mainWindow
		color: Dynamic.color.background
		width: 1000
		height: 450
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
					if (pathView.count > 0) {
						pathView.currentIndex = 0;
					}
				}

				Keys.onRightPressed: pathView.focus = true
				Keys.onLeftPressed: pathView.focus = true
				Keys.onEscapePressed: mainWindow.visible = false
			}

			PathView {
				id: pathView

				Layout.fillWidth: true
				Layout.fillHeight: true
				clip: true
				model: root.filteredWallpaperList
				pathItemCount: 7

				Keys.onPressed: event => {
					if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
						Quickshell.execDetached({
							command: ["sh", "-c", `~/.config/quickshell/caylx/scripts/colors/applyWallpaper.sh "${root.filteredWallpaperList[currentIndex]}"`]
						});
						mainWindow.visible = false
					}
					if (event.key === Qt.Key_Left)
						decrementCurrentIndex();
					if (event.key === Qt.Key_Right)
						incrementCurrentIndex();
					if (event.key === Qt.Key_Tab)
						searchField.focus = true;
					if (event.key === Qt.Key_Escape)
						mainWindow.visible = false
				}

				delegate: Item {
                    id: delegateItem
                    required property var modelData
                    required property int index
                    width: 350
                    height: 220
                    scale: PathView.scale
                    z: PathView.z
                    opacity: PathView.opacity

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 10
                        color: "#2a2a2a"
                        radius: 16
                        border.color: pathView.currentIndex === delegateItem.index ? Dynamic.color.primary : "transparent"
                        border.width: 5

                        Image {
                            id: img
                            anchors.fill: parent
                            anchors.margins: 3
                            source: "file://" + delegateItem.modelData
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                            smooth: true
                            
                            layer.enabled: true
                            layer.effect: OpacityMask {
                                maskSource: Item {
                                    width: img.width
                                    height: img.height
                                    Rectangle {
                                        anchors.fill: parent
                                        radius: 13  // Set this to your desired corner radius
                                    }
                                }
                            }

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
                                    command: ["sh", "-c", `~/.config/quickshell/caylx/scripts/colors/applyWallpaper.sh "${delegateItem.modelData}"`]
                                });
                                mainWindow.visible = false
                            }
                        }
                    }
                }

				path: Path {
					startX: -200
					startY: pathView.height / 2

					PathAttribute {
						name: "z"
						value: 0
					}
					PathAttribute {
						name: "scale"
						value: 0.5
					}
					PathAttribute {
						name: "opacity"
						value: 0.3
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
						value: 1.0
					}
					PathAttribute {
						name: "opacity"
						value: 1.0
					}

					PathLine {
						x: pathView.width + 200
						y: pathView.height / 2
					}

					PathAttribute {
						name: "z"
						value: 0
					}
					PathAttribute {
						name: "scale"
						value: 0.5
					}
					PathAttribute {
						name: "opacity"
						value: 0.3
					}
				}

				preferredHighlightBegin: 0.5
				preferredHighlightEnd: 0.5
			}
		}
	}
	
	IpcHandler {
		target: "wallpaperSelector"

		function open(): void { mainWindow.visible = true }
		function close(): void { mainWindow.visible = false }
		function toggle(): void { mainWindow.visible = !mainWindow.visible }
	}
}
