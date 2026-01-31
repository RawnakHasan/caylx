import Quickshell.Services.Mpris
import QtQuick

import qs.common.components
import qs.common.colors

Pill {
    height: 25
    width: 100
    radius: 25 / 2

    icon: "music_note"
    pillText: Mpris.players.values[0].trackTitle || "UnknownTitle"
    maxWidth: 150
}