import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland

import "../theme"

PanelWindow {
    id: launcherWindow
    property var shellRoot: null
    
    anchors { top: true; bottom: true; left: true; right: true }
    color: "transparent"
    
    focusable: true 
    WlrLayershell.layer: WlrLayer.Overlay 
    
    Rectangle {
        anchors.fill: parent
        color: Theme.base
        opacity: 0.6 
        
        MouseArea {
            anchors.fill: parent
            onClicked: if (shellRoot) shellRoot.isLauncherOpen = false
        }
    }
    
    Rectangle {
        width: 600
        height: 450
        anchors.centerIn: parent
        color: Theme.base
        radius: 12
        border.color: Theme.accent
        border.width: 2
        
        MouseArea { anchors.fill: parent }
        
        ColumnLayout {
            id: layoutRoot
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            
            property var allApps: DesktopEntries.applications.values
            property var filteredApps: {
                var query = searchBox.text.toLowerCase();
                if (query === "") return allApps;
                return allApps.filter(app => app.name.toLowerCase().includes(query));
            }
            
            TextField {
                id: searchBox
                Layout.fillWidth: true
                placeholderText: "Search apps..."
                
                font.family: Theme.defaultFont.family
                font.pixelSize: 18
                color: Theme.text
                
                background: Rectangle {
                    color: Theme.surface0
                    radius: 8
                    border.color: searchBox.activeFocus ? Theme.accent : Theme.surface1
                    border.width: 1
                }
                
                Connections {
                    target: launcherWindow
                    function onVisibleChanged() {
                        if (launcherWindow.visible) {
                            searchBox.forceActiveFocus();
                            searchBox.text = ""; 
                            appList.currentIndex = 0; // Liste auf Anfang zurücksetzen
                        }
                    }
                }
                
                // Setzt die Markierung bei jedem Tippen wieder auf das oberste Element
                onTextChanged: appList.currentIndex = 0

                // --- NEU: PFEILTASTEN STEUERUNG ---
                Keys.onUpPressed: {
                    appList.decrementCurrentIndex();
                    event.accepted = true; // Verhindert, dass der Text-Cursor springt
                }
                Keys.onDownPressed: {
                    appList.incrementCurrentIndex();
                    event.accepted = true;
                }
                
                // Führt nun das AKTUELL MARKIERTE Programm aus, nicht zwingend das erste
                onAccepted: {
                    if (layoutRoot.filteredApps.length > 0 && appList.currentIndex >= 0) {
                        layoutRoot.filteredApps[appList.currentIndex].execute();
                        if (shellRoot) shellRoot.isLauncherOpen = false;
                    }
                }
            }
            
            ListView {
                id: appList
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 5
                
                model: layoutRoot.filteredApps
                currentIndex: 0 // Speichert, welches Element gerade markiert ist
                
                delegate: Rectangle {
                    width: ListView.view.width
                    height: 50
                    radius: 8
                    
                    // --- NEU: DYNAMISCHE HERVORHEBUNG ---
                    // Überprüft, ob dieses Element per Tastatur markiert ist oder die Maus darüber schwebt
                    property bool isSelected: ListView.view.currentIndex === index
                    property bool isHovered: mouseArea.containsMouse
                    
                    color: (isSelected || isHovered) ? Theme.surface1 : "transparent"
                    
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        text: modelData.name 
                        color: (isSelected || isHovered) ? Theme.accent : Theme.text
                        font.family: Theme.defaultFont.family
                        font.pixelSize: 16
                    }
                    
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true // Wichtig, damit isHovered funktioniert, ohne dass man klickt!
                        
                        // Wenn die Maus drüberfährt, wird das Element automatisch zur aktiven Markierung (für "Enter")
                        onEntered: ListView.view.currentIndex = index
                        
                        onClicked: {
                            modelData.execute();
                            if (shellRoot) shellRoot.isLauncherOpen = false;
                        }
                    }
                }
            }
        }
    }
}
