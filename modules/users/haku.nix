{ config, pkgs, ... }:

{
  users.users.haku = { 
    isNormalUser = true;
    description = "Haku";
    hashedPasswordFile = config.sops.secrets."haku-password".path;
    # initialPassword = "haku";
    extraGroups = [ "networkmanager" "wheel" "video" "gamemode" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZIedSYR0vz3AWo2pykzFiHFCDfKuswPluT4puCsTD6 haku@kohaku" ];
  };

  # Zsh auf Systemebene aktivieren, damit Login funktioniert
  programs.zsh.enable = true;
}
