{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    history = {
      size = 10000;
      save = 10000;
      share = true;
      path = "${config.home.homeDirectory}/.zsh_history";
    };

    shellAliases = {
      # NixOS Maintenance
      nix-switch = "sudo nixos-rebuild switch --flake .#kohaku";
      nix-check = "sudo nixos-rebuild dry-activate --flake .#kohaku";
      nix-clean = "sudo nix-collect-garbage -d";
      
      # Tools
      ls = "ls --color=auto";
      ll = "ls -lah";
      grep = "grep --color=auto";
      ".." = "cd ..";
      
      # Git
      gs = "git status";
      ga = "git add .";
      gc = "git commit -m";
      gp = "git push";
    };

    defaultKeymap = "viins"; 

    initContent = ''
      export TERM=xterm-256color 
      bindkey "^?" backward-delete-char
    '';
  };
}
