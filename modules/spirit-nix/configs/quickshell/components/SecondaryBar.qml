import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import "../theme"

PanelWindow {
    id: panel
    property var shellRoot: null
    
    anchors {
        top: true
        left: true
        right: true
    }
    
    implicitHeight: Theme.barHeight
    color: "transparent"

    // Gleiche Sichtbarkeits-Logik wie bei der Haupt-Bar
    visible: (Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWindow) 
             ? !Hyprland.focusedMonitor.activeWindow.fullscreen 
             : true

    Rectangle {
        anchors.fill: parent
        color: Theme.base
        opacity: 0.95
        
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 2
            // Etwas dezentere Unterstreichung für den 2. Monitor (Surface0 statt Accent)
            color: Theme.surface0 
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 10

        // HIER WEISEN WIR DIE WORKSPACES 6-10 ZU
        Workspaces {
            workspaceList: [6, 7, 8, 9, 10]
        }

        Item { Layout.fillWidth: true }

        // Fenstertitel (nur von Fenstern auf diesem Monitor)
        Rectangle {
            color: Theme.surface0
            radius: Theme.radius
            Layout.preferredHeight: 32
            Layout.preferredWidth: Math.min(400, titleText.implicitWidth + 30)
            visible: titleText.text !== ""
            
            Text {
                id: titleText
                anchors.centerIn: parent
                // Wir zeigen nur den Titel, wenn das fokussierte Fenster auch auf diesem Monitor ist
                text: (Hyprland.focusedWindow && Hyprland.focusedWindow.monitor === screen.name) 
                      ? Hyprland.focusedWindow.title 
                      : ""
                color: Theme.text
                font: Theme.defaultFont
                elide: Text.ElideRight
                width: parent.width - 20
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Item { Layout.fillWidth: true }

        // Minimale Uhr am rechten Rand
        Text {
            id: clock
            text: Qt.formatDateTime(new Date(), "HH:mm")
            color: Theme.subtext // Etwas unauffälligere Farbe
            font: Theme.defaultFont
            
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), "HH:mm")
            }
        }
    }
}
