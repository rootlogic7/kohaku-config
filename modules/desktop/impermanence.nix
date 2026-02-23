# modules/desktop/impermanence.nix
{ config, lib, ... }:

{
  environment.persistence."/persist" = {
    # --- User-Ordner (für 'haku', Desktop only) ---
    users.haku = {
      directories = [
        "Tresor"
        ".mozilla"
        ".config/mozilla"
        ".cache/mozilla"
        ".config/keepassxc"
      ];
    };
  };
}
