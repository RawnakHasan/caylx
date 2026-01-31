import QtQuick

import qs.common
import qs.common.colors

Text {
    property string icon: "\ueb8b"
    property int iconSize: Appearance.iconSize
    property int iconHorizontalCenterOffset: -1
    property int iconVerticalCenterOffset: -1

    id: root
    anchors.centerIn: parent
    anchors.verticalCenterOffset: iconVerticalCenterOffset
    anchors.horizontalCenterOffset: iconHorizontalCenterOffset
    font.family: Appearance.iconFont
    font.weight: Font.Normal + (Font.DemiBold - Font.Normal) * 1
    renderType: Text.NativeRendering
    font.variableAxes: { 
        "FILL": 1,
        "opsz": iconSize,
    }
    font.hintingPreference: Font.PreferNoHinting
    text: root.icon
    font.pixelSize: root.iconSize  // Set a reasonable size
    verticalAlignment: Text.AlignVCenter
    color: Dynamic.color.on_primary
    horizontalAlignment: Text.AlignHCenter
}