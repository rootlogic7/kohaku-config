import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import "../theme"

RowLayout {
    id: wsLayout
    spacing: 8

    // Die Liste der Workspaces (kann von außen überschrieben werden für Monitor 2)
    property var workspaceList: [1, 2, 3, 4, 5]

    Repeater {
        model: wsLayout.workspaceList
        
        delegate: Rectangle {
            width: 32
            height: 32
            radius: 8

            // --- LOGIK (KORRIGIERT & REAKTIV) ---
            
            // Wir suchen in den tatsächlichen Werten (.values) des Models.
            // QML überwacht das automatisch. Wenn Fenster einen Workspace erschaffen/löschen, 
            // aktualisiert sich 'hyprWs' sofort.
            property var hyprWs: Hyprland.workspaces.values.find(w => w.id === modelData)
            
            // Ist dieser Workspace gerade aktiv?
            property bool isActive: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === modelData

            // Ist der Workspace besetzt? (Er existiert in der Liste, ist aber nicht zwingend aktiv)
            property bool isOccupied: hyprWs !== undefined

            // --- STYLING ---

            color: isActive ? Theme.accent : (isOccupied ? Theme.surface1 : Theme.surface0)
            Behavior on color { ColorAnimation { duration: 200 } }

            Text {
                anchors.centerIn: parent
                text: modelData
                color: isActive ? Theme.base : (isOccupied ? Theme.text : Theme.subtext)
                font: Theme.defaultFont
            }

            // --- INTERAKTION ---

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("workspace " + String(modelData))
            }
        }
    }
}
