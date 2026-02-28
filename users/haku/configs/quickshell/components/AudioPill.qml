import QtQuick
import Quickshell.Services.Pipewire
import "../theme"

Pill {
    id: root
    clickable: true
    property var shellRoot: null
    
    // Öffnet dein bestehendes AudioPanel bei Klick
    onClicked: if (shellRoot) shellRoot.isAudioOpen = !shellRoot.isAudioOpen

    property var activeAudio: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio : null
    property int volumePercent: activeAudio ? Math.round(activeAudio.volume * 100) : 0
    property bool isMuted: activeAudio ? activeAudio.muted : false

    property string volIcon: {
        if (isMuted || volumePercent === 0) return "󰝟"
        if (volumePercent < 33) return "󰕿"
        if (volumePercent < 66) return "󰖀"
        return "󰕾"
    }

    Text { text: root.volIcon; color: root.isMuted ? Theme.red : Theme.accent; font: Theme.defaultFont }
    Text { text: root.volumePercent + "%"; color: Theme.text; font: Theme.defaultFont }
}
