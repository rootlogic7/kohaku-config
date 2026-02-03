{ config, pkgs, ... }:

{
  # Home Manager braucht diese Infos
  home.username = "haku";
  home.homeDirectory = "/home/haku";

  # --- Hyprland Konfiguration ---
  wayland.windowManager.hyprland = {
    enable = true;
    
    # Hier passiert die Magie: Wir schreiben die Config direkt in Nix
    settings = {
      # Monitor Setup (Auto)
      monitor = ",preferred,auto,auto";

      # Eingabegeräte
      input = {
        kb_layout = "de";
        kb_variant = "";
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
      };

      # Variablen
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$fileManager" = "ghostty -e yazi";

      # Tastenbindungen
      bind = [
        # Wichtig: Startet Ghostty statt Kitty!
        "$mod, Q, exec, $terminal"
        
        # Fenster schließen / Hyprland beenden
        "$mod, C, killactive,"
        "$mod, M, exit,"
        
        # Files & Fenster-Management
        "$mod, E, exec, $fileManager"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"

        # Fokus wechseln mit Pfeiltasten
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ];

      # Design (CachyOS / Hyprland Standard Stil)
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 0.9;
      };
    };
  };

  # Shell Integration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Dieser State Version Wert darf nicht geändert werden
  home.stateVersion = "24.11";
}
