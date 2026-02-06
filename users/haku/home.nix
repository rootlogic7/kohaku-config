{ config, pkgs, inputs, vars, ... }:

{
  imports = [
    ./desktop/hyprland.nix
    ./desktop/quickshell.nix
    ./cli/shell.nix
  ];

  home.username = vars.user;
  home.homeDirectory = "/home/${vars.user}";
  
  # --- Allgemeine User Pakete ---
  home.packages = with pkgs; [
    # GUI Tools
    firefox
    yazi
    wl-clipboard

    # CLI Utilities (Power User)
    ripgrep
    fd
    btop
    tldr
    fzf

    # Gaming
    mangohud
  ];

  # Fonts Konfiguration (für Home-Manager verwaltet)
  fonts.fontconfig.enable = true;

  home.stateVersion = "24.11";
}
