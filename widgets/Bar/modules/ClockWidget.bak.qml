import QtQuick
import QtQuick.Layouts

import qs.common
import qs.common.colors

Rectangle {
    id: root
    color: Dynamic.color.secondary_container
    radius: Appearance.clockWidgetRadius
    property bool showDate: true  // Add this property
    property string timeText: ""
    property string dateText: ""
    implicitWidth: timeText.implicitWidth + dotText.implicitWidth + dateText.implicitWidth + 30
    implicitHeight: Appearance.clockWidgetHeight

    RowLayout {
        id: row
        spacing: 4
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: timeText
            text: root.timeText  // Bind to property
            font.pixelSize: Appearance.barTextSize
            font.family: Appearance.fontFamily
            font.bold: true
            color: Dynamic.color.primary
        }

        Text {
            id: dotText
            visible: root.showDate
            font.pixelSize: Appearance.barTextSize
            color: Dynamic.color.tertiary
            font.family: Appearance.fontFamily
            text: "•"
        }

        Text {
            id: dateText
            visible: root.showDate
            font.pixelSize: Appearance.barTextSize
            color: Dynamic.color.on_secondary_container
            font.family: Appearance.fontFamily
            text: root.dateText  // Bind to property
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            const now = new Date()
            root.timeText = Qt.formatDateTime(now, "hh:mm A")
            root.dateText = Qt.formatDateTime(now, "ddd, dd/MM")
        }
    }
    
    Component.onCompleted: {
        const now = new Date()
        root.timeText = Qt.formatDateTime(now, "hh:mm A")
        root.dateText = Qt.formatDateTime(now, "ddd, dd/MM")
    }
}