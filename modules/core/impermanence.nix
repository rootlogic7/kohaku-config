# modules/core/impermanence.nix
{ config, lib, ... }:

{
  environment.persistence."/persist" = {
    hideMounts = false;
    
    # --- System-Ordner ---
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    
    # --- System-Dateien ---
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
    
    # --- User-Ordner (für 'haku', nur Core) ---
    users.haku = {
      directories = [
        "spirit-os"
        ".ssh"
      ];
      files = [
        ".zsh_history"
      ];
    };
  };
}
