{ config, pkgs, inputs, vars, ... }:

{
  imports = [
    # Hier laden wir die "Spirit-Nix" Distro
    # Das importiert automatisch Hyprland, Quickshell und die Shell-Config
    ../../modules/spirit-nix/default.nix
  ];

  home.username = vars.user;
  home.homeDirectory = "/home/${vars.user}";
  
  # --- User-Spezifische Tools ---
  # Alles was NICHT Teil des Standard-Themes ist (z.B. persönliche Arbeits-Tools)
  # Ghostty, Kitty, Hyprland-Tools sind jetzt alle in Spirit-Nix!
  home.packages = with pkgs; [
    firefox
    yazi
    wl-clipboard
    ripgrep
    fd
    btop
    tldr
    fzf
    mangohud
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "24.11";
}
