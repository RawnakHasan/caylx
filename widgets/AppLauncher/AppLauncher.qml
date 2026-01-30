import Quickshell
import Quickshell.Io
import QtQuick
import "root:///scripts/fuzzySort.js" as FuzzySort

Scope {
    id: root
    property bool isOpen: false
    
    PanelWindow {
        visible: root.isOpen
        focusable: true
        implicitWidth: 600
        implicitHeight: 400

        onVisibleChanged: {
            if (visible) {
                input.text = ""
                input.forceActiveFocus()
                list.currentIndex = 0
            }
        }
        
        Column {
            anchors.fill: parent
            
            TextInput {
                id: input
                width: parent.width
                focus: true
                
                Keys.onReturnPressed: {
                    if (list.model.length > 0) {
                        list.model[list.currentIndex].execute()
                        root.isOpen = false
                    }
                }
                
                Keys.onDownPressed: {
                    list.incrementCurrentIndex()
                }
                
                Keys.onUpPressed: {
                    list.decrementCurrentIndex()
                }
                
                Keys.onEscapePressed: root.isOpen = false
            }
            
            ListView {
                id: list
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height - input.height
                
                model: input.text.length === 0
                    ? DesktopEntries.applications
                    : FuzzySort.go(
                        input.text,
                        DesktopEntries.applications.values,
                        { keys: ["name", "genericName"] }
                    ).map(a => a.obj)
                
                delegate: Text {
                    text: modelData.name
                }
            }
        }
    }
    
    IpcHandler {
        target: "AppLauncher"
        function open(): void   { root.isOpen = true }
        function close(): void  { root.isOpen = false }
        function toggle(): void { root.isOpen = !root.isOpen }
    }
}
