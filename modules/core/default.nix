{ config, pkgs, vars, ... }:

{
  # --- Nix Einstellungen ---
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    
    # Binary Caches für schnellere Builds
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Garbage Collection (Automatisch aufräumen)
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./impermanence.nix
  ];

  # --- Basis Pakete ---
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    pciutils
    fastfetch
    sops
  ];

  # --- Locale & Zeit ---
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # --- Security ---
  # Basis SSH Config (Host Keys bleiben im Host-File)
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

}
