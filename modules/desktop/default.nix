# modules/desktop/default.nix
{ config, pkgs, ... }:
# === === DESKTOP profile === ===
{
  imports = [
    ../core/greeter.nix
    ./impermanence.nix
  ];

  environment.systemPackages = with pkgs; [
    # Der Hyprland Wrapper
    (writeShellScriptBin "Hyprland" ''
      if [ "$HYPRLAND_WRAPPER_ACTIVE" = "1" ]; then
        exec ${pkgs.hyprland}/bin/Hyprland "$@"
      else
        export HYPRLAND_WRAPPER_ACTIVE=1
        exec start-hyprland "$@"
      fi
    '')
  ];
}
