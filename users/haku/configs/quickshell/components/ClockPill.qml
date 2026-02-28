import QtQuick
import "../theme"

Pill {
    id: root
    clickable: true 
    
    // Platzhalter für unser nächstes Panel!
    onClicked: print("Kalender-Panel soll geöffnet werden")

    Text {
        id: clockText
        text: Qt.formatDateTime(new Date(), "HH:mm")
        color: Theme.text
        font: Theme.defaultFont
        
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clockText.text = Qt.formatDateTime(new Date(), "HH:mm")
        }
    }
}
