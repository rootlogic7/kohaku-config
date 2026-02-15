import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io // WICHTIG: Hier kommt der IpcHandler her

import "./components"
import "./theme"

ShellRoot {
    id: root

    property bool isLauncherOpen: false
    property var activePopup: null

    // Der korrekte IpcHandler
    IpcHandler {
        target: "spirit"
        
        // WICHTIG: In Quickshell MUSS der Rückgabetyp (: void) explizit angegeben werden!
        function toggle(): void {
            root.isLauncherOpen = !root.isLauncherOpen;
            console.log("Launcher Status: " + root.isLauncherOpen);
        }
    }

    // 1. Instantiator für deine Bars
    Instantiator {
        model: Quickshell.screens
        
        delegate: Loader {
            active: true
            sourceComponent: (modelData.name === "DP-1" || modelData.primary) ? mainBar : secondaryBar
            
            Component {
                id: mainBar
                Bar { screen: modelData; shellRoot: root }
            }
            
            Component {
                id: secondaryBar
                SecondaryBar { screen: modelData; shellRoot: root }
            }
        }
    }

    // 2. Instantiator für den schwebenden Launcher
    Instantiator {
        model: Quickshell.screens
        delegate: Launcher {
            screen: modelData
            shellRoot: root
            // Sichtbar, wenn getoggelt UND auf dem aktiven Monitor
            visible: root.isLauncherOpen && (Hyprland.focusedMonitor && Hyprland.focusedMonitor.name === modelData.name)
        }
    }
}
