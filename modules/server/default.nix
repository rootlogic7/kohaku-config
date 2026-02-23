# modules/server/default.nix
{ config, pkgs, ... }:

{
  # Basis-Einstellungen kommen aus modules/core/default.nix!
  
  # HIER aktivieren wir später Forgejo (Git-Server) und Syncthing
  
  # Zusätzliche System-Pakete, die wirklich NUR ein Server braucht
  environment.systemPackages = with pkgs; [
    # (Aktuell leer, weil git, curl und wget schon in core sind)
  ];
}
