import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import qs.common
import qs.common.colors

/**
 * A progress bar with both ends rounded and text acts as clipping like OneUI 7's battery indicator.
 */
ProgressBar {
    id: root
    
    property bool vertical: false
    property real valueBarWidth: 30
    property real valueBarHeight: Appearance.barWidgetHeight
    property color highlightColor: Dynamic.color.primary
    property color trackColor: Dynamic.color.primary_container
    property alias radius: backgroundRect.radius
    property string text
    
    default property Item textMask: Item {
        width: valueBarWidth
        height: valueBarHeight
        Text {
            font: root.font
            text: root.text
        }
    }
    
    text: Math.round(value * 100)
    font {
        pixelSize: 13
        weight: text.length > 2 ? Font.Medium : Font.DemiBold
    }
    
    background: Item {
        implicitHeight: valueBarHeight
        implicitWidth: valueBarWidth
    }
    
    contentItem: Item {
        anchors.fill: parent
        
        // The actual visual content that will be masked
        Rectangle {
            id: backgroundRect
            anchors.fill: parent
            radius: 9999
            color: root.trackColor
            visible: false  // Hidden because it's used as a source
            
            Rectangle {
                id: progressFill
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: undefined
                }
                width: parent.width * root.visualPosition
                height: parent.height
                
                states: State {
                    name: "vertical"
                    when: root.vertical
                    AnchorChanges {
                        target: progressFill
                        anchors {
                            top: undefined
                            bottom: parent.bottom
                            left: parent.left
                            right: parent.right
                        }
                    }
                    PropertyChanges {
                        target: progressFill
                        width: parent.width
                        height: parent.height * root.visualPosition
                    }
                }
                
                color: root.highlightColor
            }
        }
        
        // First mask: apply rounded corners
        OpacityMask {
            id: roundingMask
            visible: false  // Hidden because it's used as a source
            anchors.fill: parent
            source: backgroundRect
            maskSource: Rectangle {
                width: backgroundRect.width
                height: backgroundRect.height
                radius: backgroundRect.radius
            }
        }
        
        // Final mask: cut out the text
        OpacityMask {
            anchors.fill: parent
            source: roundingMask
            invert: true
            maskSource: root.textMask
        }
    }
}