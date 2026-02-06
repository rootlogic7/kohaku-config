{ config, pkgs, vars, ... }:

{
  users.users.${vars.user} = { 
    isNormalUser = true;
    description = "Haku";
    hashedPasswordFile = config.sops.secrets."haku-password".path;
    extraGroups = [ "networkmanager" "wheel" "video" "gamemode" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ vars.sshKey ];
  };

  # Zsh auf Systemebene aktivieren, damit Login funktioniert
  programs.zsh.enable = true;
}
