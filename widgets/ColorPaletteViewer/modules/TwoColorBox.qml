import QtQuick

import qs.common

Item {
    id: root
    
    // Four customizable properties
    property string primaryText: "Primary Container"
    property string secondaryText: "On Primary Container"
    property color mainColor: "#90EE90"  // Light green
    property color _onMainColor: "#1B4D1B"  // Dark green
    
    property int radius: 10

    width: 200
    height: 100
    
    Column {
        anchors.fill: parent
        spacing: 0
        
        // Primary container
        Rectangle {
            width: parent.width
            height: parent.height * 0.5
            color: root.mainColor
            topLeftRadius: root.radius
            topRightRadius: root.radius

            Text {
                text: root.primaryText
                font.pixelSize: Appearance.swatchesPixelSize
                color: root._onMainColor
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 10
            }
        }
        
        // Secondary container
        Rectangle {
            width: parent.width
            height: parent.height * 0.5
            color: root._onMainColor
            bottomLeftRadius: root.radius
            bottomRightRadius: root.radius
            
            Text {
                text: root.secondaryText
                font.pixelSize: Appearance.swatchesPixelSize
                color: root.mainColor
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
            }
        }
    }
}