{ config, pkgs, inputs, ... }:

{
  home.packages = [
    # FIX: Nutzung von stdenv.hostPlatform.system statt pkgs.system entfernt die Warnung
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.qt6.qtdeclarative
    
    # Fonts für das UI
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-color-emoji
  ];

  # Verlinkt die Assets aus dem Distro-Ordner
  xdg.configFile."quickshell".source = ../configs/quickshell;
}
