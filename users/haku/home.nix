{ config, pkgs, inputs, ... }:

{
  imports = [
    # Wir laden die Basis (Hyprland, Shell, Theme)
    ../../modules/spirit-nix/default.nix
  ];

  home.username = "haku";
  home.homeDirectory = "/home/haku";
  
  # --- User-Spezifische Pakete ---
  # Alles, was Haku braucht, aber nicht jeder User haben muss
  home.packages = with pkgs; [
    firefox
    yazi
    vesktop      # Discord
    mangohud
    obsidian
    # steam      # Steam ist meist besser via system config, aber Tools hier sind ok
  ];

  # --- Git Identität ---
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Haku";
        email = "rootlogic7@proton.me";
      };
      init.defaultBranch = "main";
    };
  };

  # --- Hardware & Workspace Overrides ---
  # Hier definieren wir, wie Spirit-OS auf DEINER Hardware (Kohaku) läuft
  wayland.windowManager.hyprland.settings = {
    
    # 1. Monitore
    monitor = [
      "DP-1,3440x1440@100,0x0,auto"
      "HDMI-A-1,1920x1080@100,3440x0,auto"
    ];

    # 2. Workspace Bindings
    # Wir zwingen Workspace 1-5 auf deinen Hauptmonitor
    workspace = [
      "1, monitor:DP-1, default:true"
      "2, monitor:DP-1"
      "3, monitor:DP-1"
      "4, monitor:DP-1"
      "5, monitor:DP-1"
      
      # Optional: Rest auf den zweiten?
      # "6, monitor:HDMI-A-1"
    ];

    # 3. Maus-Einstellungen (Gaming)
    input = {
      sensitivity = 0;
      accel_profile = "flat";
    };
  };

  home.stateVersion = "24.11";
}
