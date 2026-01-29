import QtQuick

import qs.common

Item {
    id: root
    
    property string topLeftText: "Template Text"
    property string topRightText: "Template Text"
    property string middleText: "Template Text"
    property string bottomText: "Template Text"
    
    property color fixedColor: "#fff"
    property color fixedDimColor: "#fff"
    property color _onFixedColor: "#fff"
    property color _onFixedVariantColor: "#fff"
    
    property int radius: 10

    width: 200
    height: 150
    
    Column {
        anchors.fill: parent
        spacing: 0
        
        // Top row with two boxes
        Row {
            width: parent.width
            height: parent.height * 0.4
            spacing: 0
            
            Rectangle {
                width: parent.width * 0.5
                height: parent.height
                color: root.fixedColor
                topLeftRadius: root.radius
                
                Text {
                    text: root.topLeftText
                    font.pixelSize: Appearance.swatchesPixelSize
                    color: root._onFixedColor
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 8
                    wrapMode: Text.WordWrap
                    width: parent.width - 16
                }
            }
            
            Rectangle {
                width: parent.width * 0.5
                height: parent.height
                color: root.fixedDimColor
                topRightRadius: root.radius
                
                Text {
                    text: root.topRightText
                    font.pixelSize: Appearance.swatchesPixelSize
                    color: root._onFixedColor
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 8
                    wrapMode: Text.WordWrap
                    width: parent.width - 16
                }
            }
        }
        
        // Middle box
        Rectangle {
            width: parent.width
            height: parent.height * 0.3
            color: root._onFixedColor
            
            Text {
                text: root.middleText
                font.pixelSize: Appearance.swatchesPixelSize
                color: root.fixedColor
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 8
            }
        }
        
        // Bottom box
        Rectangle {
            width: parent.width
            height: parent.height * 0.3
            color: root._onFixedVariantColor
            bottomLeftRadius: root.radius
            bottomRightRadius: root.radius
            
            Text {
                text: root.bottomText
                font.pixelSize: Appearance.swatchesPixelSize
                color: root.fixedColor
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 8
            }
        }
    }
}
