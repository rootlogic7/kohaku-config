{ config, pkgs, lib, ... }:

{
  # 1. sysc-greet aktivieren
  services.sysc-greet = {
    enable = true;
    compositor = "hyprland"; 
  };

  # 2. HIJACK: Wir nutzen start-hyprland
  services.greetd.settings.default_session = lib.mkForce {
    command = "start-hyprland";
    user = "greeter";
  };

  # 3. Verlinkungs-Trick ins Home-Verzeichnis
  systemd.services.greetd.preStart = ''
    mkdir -p /var/lib/greeter/.config/hypr
    ln -sf /etc/greetd/hyprland.conf /var/lib/greeter/.config/hypr/hyprland.conf
    chown -R greeter:greeter /var/lib/greeter
  '';

  # 4. Gemeinsame Basis-Konfiguration für Hyprland
  environment.etc."greetd/hyprland.conf".text = ''
    # --- Gemeinsame Settings (Tastatur & Fokus-Schutz) ---
    input {
      kb_layout = de
      follow_mouse = 0
    }
    
    # --- Cursor-Verhalten ---
    cursor {
      inactive_timeout = 1
      hide_on_key_press = true
    }
    
    misc {
      disable_splash_rendering = true
      disable_hyprland_logo = true
      background_color = 0x000000
    }
    animations {
      enabled = false
    }
    
    # --- Terminal starten ---
    exec-once = [workspace 1; fullscreen] ${pkgs.kitty}/bin/kitty -e sysc-greet
  '';
}
