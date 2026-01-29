import QtQuick

import qs.common

Item {
    id: root
    
    property string text: "Color"
    property color backgroundColor: "#808080"
    property color textColor: "#FFFFFF"
    property int topLeftRadius: 0
    property int topRightRadius: 0
    property int bottomLeftRadius: 0
    property int bottomRightRadius: 0
    property int fontSize: Appearance.swatchesPixelSize
    
    width: 200
    height: 60
    
    Rectangle {
        anchors.fill: parent
        color: root.backgroundColor
        topLeftRadius: root.topLeftRadius
        topRightRadius: root.topRightRadius
        bottomLeftRadius: root.bottomLeftRadius
        bottomRightRadius: root.bottomRightRadius

        Text {
            text: root.text
            font.pixelSize: root.fontSize
            color: root.textColor
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
            width: parent.width - 20
            wrapMode: Text.WordWrap
        }
    }
}
