import QtQuick

import qs.common
import qs.common.colors

Text {
    property string icon: "\ueb8b"
    property int iconSize: 20

    id: root
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -1
    anchors.horizontalCenterOffset: -1
    font.family: Appearance.iconFont
    text: root.icon
    font.pixelSize: root.iconSize  // Set a reasonable size
    verticalAlignment: Text.AlignVCenter
    color: Dynamic.color.on_primary
    horizontalAlignment: Text.AlignHCenter
}