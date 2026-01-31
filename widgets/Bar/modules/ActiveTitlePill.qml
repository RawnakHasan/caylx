import QtQuick
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.common
import qs.common.components
import qs.common.colors

Pill {
    id: root
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    padding: 5
    maxWidth: 150
    bubbleText: `${Hyprland.focusedWorkspace?.id} ` ?? ""
    pillText:  (activeWindow?.activated && activeWindow?.title) ? (activeWindow.appId.includes('.') ? activeWindow.title : activeWindow.appId) : "Desktop"
}
