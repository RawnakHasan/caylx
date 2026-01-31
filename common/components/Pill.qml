import QtQuick
import QtQuick.Layouts
import qs.common
import qs.common.colors

Rectangle {
    id: root
    
    property string icon: "\ueb8b"
    property string pillText: "pillText"
    property bool pillTextBold: true
    property int textSize: 16
    property string bubbleText: ""
    property real padding: 0
    property int iconSize: 20
    property int maxWidth: -1  // -1 means no limit
    property int pillTextOffset: 10
    property int iconVerticalCenterOffset: -1
    property int iconHorizontalCenterOffset: -1
    
    readonly property bool useIcon: root.bubbleText === ""
    
    signal clicked()
    
    implicitHeight: Appearance.pillHeight
    radius: Appearance.pillRadius
    implicitWidth: {
        var totalWidth = leftContent.width + text.implicitWidth + 17;
        return root.maxWidth > 0 ? Math.min(totalWidth, root.maxWidth) : totalWidth;
    }
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
            iconVerticalCenterOffset: root.iconVerticalCenterOffset
            iconHorizontalCenterOffset: root.iconHorizontalCenterOffset
        }
        
        Text {
            id: bubbleElement
            visible: !root.useIcon
            anchors.centerIn: parent
            color: Dynamic.color.on_primary
            anchors.verticalCenterOffset: -1
            font.pixelSize: root.textSize
            text: root.bubbleText
            font.family: Appearance.fontFamily
            font.bold: true
            renderType: Text.NativeRendering
        }
    }
    
    Text {
        id: text
        anchors.centerIn: parent
        leftPadding: root.padding
        anchors.verticalCenterOffset: -1
        anchors.horizontalCenterOffset: root.pillTextOffset
        color: Dynamic.color.on_secondary_container
        text: root.pillText
        font.family: Appearance.fontFamily
        font.pixelSize: root.textSize 
        font.bold: root.pillTextBold
        elide: Text.ElideRight  // Add ellipsis if text is too long
        maximumLineCount: 1
        width: root.maxWidth > 0 ? Math.min(implicitWidth, root.maxWidth - leftContent.width - 17) : implicitWidth
    }
}