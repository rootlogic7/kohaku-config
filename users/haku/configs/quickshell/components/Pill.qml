import QtQuick
import QtQuick.Layouts
import "../theme"

Rectangle {
    id: root
    
    // Erlaubt es uns, Kind-Elemente (wie Text) direkt in diese Pill zu packen
    default property alias content: contentRow.data
    property alias spacing: contentRow.spacing
    
    // Interaktions-Logik
    property bool clickable: false
    signal clicked()

    Layout.preferredHeight: 32
    // Die Pille passt sich automatisch an die Breite ihres Inhalts an (+ Padding)
    Layout.preferredWidth: contentRow.implicitWidth + 24
    radius: height / 2
    
    // Hover-Effekt (leuchtet immer leicht auf)
    color: mouseArea.containsMouse ? Theme.surface1 : Theme.surface0
    Behavior on color { ColorAnimation { duration: 150 } }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true 
        // Zeigt die Hand nur, wenn die Pill auch klickbar ist
        cursorShape: root.clickable ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: if (root.clickable) root.clicked()
    }

    // Zentriert den Inhalt automatisch horizontal
    RowLayout {
        id: contentRow
        anchors.centerIn: parent
        spacing: 8
    }
}
