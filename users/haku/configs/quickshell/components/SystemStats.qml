import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "../theme"

RowLayout {
    id: root
    spacing: 10

    // Properties, die sich automatisch an die UI binden
    property int cpuPercent: 0
    property int cpuTemp: 0
    property int ramPercent: 0

    // --- RAM Pill ---
    Rectangle {
        Layout.preferredHeight: 32
        Layout.preferredWidth: ramRow.implicitWidth + 24
        radius: height / 2
        color: ramMouse.containsMouse ? Theme.surface1 : Theme.surface0
        Behavior on color { ColorAnimation { duration: 150 } }

        MouseArea { 
            id: ramMouse
            anchors.fill: parent
            hoverEnabled: true 
            cursorShape: Qt.PointingHandCursor
        }

        RowLayout {
            id: ramRow
            anchors.centerIn: parent
            spacing: 8
            Text { 
                text: "" 
                color: Theme.yellow 
                font: Theme.defaultFont
            }
            Text { 
                text: root.ramPercent + "%" 
                color: Theme.text
                font: Theme.defaultFont
            }
        }
    }

    // --- CPU Pill ---
    Rectangle {
        Layout.preferredHeight: 32
        Layout.preferredWidth: cpuRow.implicitWidth + 24
        radius: height / 2
        color: cpuMouse.containsMouse ? Theme.surface1 : Theme.surface0
        Behavior on color { ColorAnimation { duration: 150 } }

        MouseArea { 
            id: cpuMouse
            anchors.fill: parent
            hoverEnabled: true 
            cursorShape: Qt.PointingHandCursor
        }

        RowLayout {
            id: cpuRow
            anchors.centerIn: parent
            spacing: 8
            Text { 
                text: "" 
                color: Theme.green 
                font: Theme.defaultFont
            }
            Text { 
                text: root.cpuPercent + "% @ " + root.cpuTemp + "°C" 
                color: Theme.text
                font: Theme.defaultFont
            }
        }
    }

    // --- LOGIK ---

    // 1. RAM Logic (/proc/meminfo)
    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: ramProc.running = true
    }

    Process {
        id: ramProc
        command: ["cat", "/proc/meminfo"]
        
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.split("\n");
                let total = 0;
                let available = 0;
                
                for (let i = 0; i < lines.length; i++) {
                    if (lines[i].includes("MemTotal:")) 
                        total = parseInt(lines[i].match(/\d+/)[0]);
                    if (lines[i].includes("MemAvailable:")) 
                        available = parseInt(lines[i].match(/\d+/)[0]);
                }

                if (total > 0) {
                    const used = total - available;
                    root.ramPercent = Math.round((used / total) * 100);
                }
            }
        }
    }

    // 2. CPU Usage Logic (/proc/stat berechnen)
    property real prevTotal: 0
    property real prevIdle: 0

    Process {
        id: cpuUsageProc
        command: ["cat", "/proc/stat"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.split("\n");
                if (lines.length > 0) {
                    const cpuLine = lines[0].trim().split(/\s+/);
                    if (cpuLine[0] === "cpu") {
                        let idle = parseInt(cpuLine[4]) + parseInt(cpuLine[5]);
                        let total = 0;
                        for (let i = 1; i < 9; i++) {
                            total += parseInt(cpuLine[i]);
                        }
                        
                        if (root.prevTotal > 0) {
                            let totalDiff = total - root.prevTotal;
                            let idleDiff = idle - root.prevIdle;
                            root.cpuPercent = Math.round((totalDiff - idleDiff) / totalDiff * 100);
                        }
                        root.prevTotal = total;
                        root.prevIdle = idle;
                    }
                }
            }
        }
    }

    // 3. CPU Temp Logic
    Process {
        id: cpuTempProc
        // Zieht sich dynamisch den ersten verfügbaren Temperatur-Sensor
        command: ["bash", "-c", "cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | head -n 1"]
        stdout: StdioCollector {
            onStreamFinished: {
                let t = parseInt(text);
                if (!isNaN(t)) {
                    root.cpuTemp = Math.round(t / 1000);
                }
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuUsageProc.running = true;
            cpuTempProc.running = true;
        }
    }
}
