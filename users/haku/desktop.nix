# users/haku/desktop.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./core.nix
    ./theme.nix
    ./hyprland.nix
    ./quickshell.nix
    ./ghostty.nix
  ];

  # --- Desktop Pakete ---
  home.packages = with pkgs; [
    ghostty
    kitty
    firefox
    obsidian
    keepassxc
  ];

  # --- Hardware-Agnostische Hyprland Fallbacks ---
  wayland.windowManager.hyprland.settings = {
    monitor = lib.mkDefault [ ",preferred,auto,1" ];
    input = {
      sensitivity = lib.mkDefault 0;
    };
  };
}
