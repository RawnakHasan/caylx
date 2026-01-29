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

  property int swatchesPixelSize: 18

  property int appLauncherWidth: 512
  property int appLauncherHeight: 224
  property int appLauncherRadius: 20
  property int appLauncherInnerRadius: 15
  property int appLauncherPadding: 16
  property int appLauncherSearchHeight: 38
  property int appLauncherSearchRadius: 10
  property int appLauncherListHeight: 128
  property int appLauncherItemHeight: 32
  property real appLauncherItemRadius: 6.67  // Changed from int to real
  property int appLauncherGapFromBar: 10
}