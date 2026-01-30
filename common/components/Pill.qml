import QtQuick
import QtQuick.Layouts
import qs.common
import qs.common.colors

Rectangle {
    id: root
    
    property string icon: "\ueb8b"
    property string pillText: "pillText"
    property string bubbleText: ""
    property int iconSize: 20
    property int maxWidth: 100
    property int pillTextOffset: 10
    
    readonly property bool useIcon: root.bubbleText === ""

    signal clicked()

    implicitHeight: Appearance.pillHeight
    radius: Appearance.pillRadius
    implicitWidth: Math.min(leftContent.width + text.implicitWidth + 17, root.maxWidth)
    color: Dynamic.color.secondary_container
    
    Rectangle {
        id: leftContent
        implicitHeight: root.implicitHeight
        // Keep circular if icon OR if bubble text is single character
        implicitWidth: (root.useIcon || root.bubbleText.length === 1) ? root.implicitHeight : Math.max(root.implicitHeight, bubbleElement.implicitWidth + 16)
        radius: root.implicitHeight
        color: Dynamic.color.primary
        
        MaterialIcon {
            id: iconElement
            visible: root.useIcon
            icon: root.icon 
            iconSize: root.iconSize
        }
        
        Text {
            id: bubbleElement
            visible: !root.useIcon
            anchors.centerIn: parent
            color: Dynamic.color.on_primary
            anchors.verticalCenterOffset: -1
            text: root.bubbleText
            font.family: Appearance.fontFamily
            font.bold: true
        }
    }
    
    Text {
        id: text
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: -1
        anchors.horizontalCenterOffset: root.pillTextOffset
        color: Dynamic.color.on_secondary_container
        text: root.pillText
        font.family: Appearance.fontFamily
    }
}