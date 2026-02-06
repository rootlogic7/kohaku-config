{ pkgs, lib, config, ... }:

let
  # Der Pfad zum lokalen Bild
  wallpaper = ./wallpaper.png;
in
{
  # 1. Wir machen das Wallpaper im System verfügbar (optional, aber sauber)
  xdg.configFile."spirit-os/wallpaper.png".source = wallpaper;

  # 2. Hyprland Konfiguration erweitern
  # Home-Manager merged Listen automatisch. Wir fügen also einfach einen neuen
  # exec-once Eintrag hinzu, ohne die anderen in hyprland.nix zu löschen.
  wayland.windowManager.hyprland.settings.exec-once = [
    # Wir nutzen ein kleines Skript, um sicherzugehen, dass swww-daemon bereit ist
    "${pkgs.bash}/bin/bash -c 'sleep 1; swww img ${wallpaper} --transition-type grow --transition-pos 0.8,0.9 --transition-step 90 --transition-fps 60'"
  ];
}
