import QtQuick
import Quickshell.Io
import "../theme"

Pill {
    id: root
    
    property int batPercent: 0
    property string batStatus: "Unknown"

    property string batIcon: {
        if (batStatus === "Charging") return "󰂄"
        if (batPercent < 10) return "󰁺"
        if (batPercent < 30) return "󰁼"
        if (batPercent < 50) return "󰁾"
        if (batPercent < 80) return "󰂀"
        if (batPercent < 100) return "󰂂"
        return "󰁹"
    }
    
    property color batColor: {
        if (batStatus === "Charging") return Theme.green
        if (batPercent <= 15) return Theme.red
        if (batPercent <= 30) return Theme.yellow
        return Theme.text
    }

    Text { text: root.batIcon; color: root.batColor; font: Theme.defaultFont }
    Text { text: root.batPercent + "%"; color: Theme.text; font: Theme.defaultFont }

    Process {
        id: batProc
        command: ["bash", "-c", "cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | awk '{s+=$1} END {if (NR>0) print int(s/NR)}'; cat /sys/class/power_supply/BAT*/status 2>/dev/null | grep -q Charging && echo Charging || echo Discharging"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n");
                if (lines.length >= 2) {
                    root.batPercent = parseInt(lines[0]);
                    root.batStatus = lines[1];
                }
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: batProc.running = true
    }
}
