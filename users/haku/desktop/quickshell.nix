{ config, pkgs, inputs, ... }:

{
  # Quickshell Paket installieren
  home.packages = [
    inputs.quickshell.packages.${pkgs.system}.default
    pkgs.qt6.qtdeclarative
    
    # Fonts, die du im UI benutzt
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-color-emoji
  ];

  # Verlinkt den Ordner "configs/quickshell" relativ zu dieser Datei
  # nach ~/.config/quickshell
  xdg.configFile."quickshell".source = ../configs/quickshell;
}
