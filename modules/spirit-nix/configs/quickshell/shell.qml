import QtQuick
import Quickshell
import Quickshell.Wayland

import "./components"
import "./theme"

ShellRoot {
    id: root

    property bool isLauncherOpen: false
    property var activePopup: null

    Instantiator {
        model: Quickshell.screens
        
        delegate: Loader {
            // Aktiviert den Loader für ALLE Bildschirme, die Hyprland meldet
            active: true
            
            // Logik: Ist es der Hauptmonitor? -> mainBar. Sonst -> secondaryBar
            sourceComponent: (modelData.name === "DP-1" || modelData.primary) 
                             ? mainBar 
                             : secondaryBar
            
            // Definiere die Haupt-Bar (bekommt automatisch Workspaces 1-5 durch den Default)
            Component {
                id: mainBar
                Bar {
                    screen: modelData
                    shellRoot: root
                }
            }
            
            // Definiere die Neben-Bar (bekommt Workspaces 6-10 durch unsere neue Datei)
            Component {
                id: secondaryBar
                SecondaryBar {
                    screen: modelData
                    shellRoot: root
                }
            }
        }
    }

    Launcher {
        visible: root.isLauncherOpen
    }
}
