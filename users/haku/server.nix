# users/haku/server.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./core.nix
  ];

  home.packages = with pkgs; [
    btop
  ];
}
