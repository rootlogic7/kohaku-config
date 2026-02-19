{ pkgs, ... }:

{
  # Spirit-Nix lädt automatisch alle seine Komponenten
  imports = [
    ./theme/default.nix
    ./desktop/hyprland.nix
    ./desktop/quickshell.nix
    ./cli/shell.nix
    ./cli/ghostty.nix
    ./cli/neovim.nix
  ];
}
