# users/haku/core.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./shell.nix
    ./neovim.nix
  ];

  home.username = "haku";
  home.homeDirectory = "/home/haku";
  
  # --- Generische Pakete (für alle Rechner) ---
  home.packages = with pkgs; [
    yazi
    fastfetch
  ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        host = "github.com";
        user = "git";
        identityFile = "/run/secrets/github-ssh-key";
        identitiesOnly = true;
      };
    };
  };

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

  home.stateVersion = "24.11";
}
