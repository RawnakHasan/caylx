pragma Singleton

import Quickshell
import QtQuick.Window

Singleton {
  property string fontFamily: "Apercu Mono Pro Regular"
  property string iconFont: "Material Symbols Rounded"
  property int barHeight: 40
  property real barMargin: 7.5
  property real barWidth: Screen.width / 2
  property int universalSpacing: 10
  property int barWidgetHeight: 25
  property int pillHeight: barWidgetHeight
  property int pillWidth: barWidgetHeight
  property int pillRadius: barWidgetHeight
  property int clockWidgetHeight: barWidgetHeight
  property int clockWidgetRadius: barWidgetHeight
  property int barTextSize: 16
  property bool isDarkModeActive: true
  property int iconSize: 20

  property int swatchesPixelSize: 18
}