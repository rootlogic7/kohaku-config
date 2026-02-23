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
      "/etc/NetworkManager/system-connections" # WLAN/LAN Passwörter
    ];
    
    # --- System-Dateien ---
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
    
    # --- User-Ordner (für 'haku') ---
    users.haku = {
      directories = [
        "spirit-os"
        ".ssh"
        ".mozilla"  # KeePassXC -> Firefox Extensions
        ".config/mozilla"
        ".cache/mozilla"
        ".config/keepassxc"
        "Tresor"
      ];
      files = [
        ".zsh_history" # Deine Shell-History
      ];
    };
  };
}
