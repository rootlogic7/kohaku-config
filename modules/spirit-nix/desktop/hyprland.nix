{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpolkitagent
    hyprlock
    hypridle
    hyprpicker
    swww
    grim
    slurp
    cliphist
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    
    settings = {
      # --- Autorun ---
      exec-once = [
        "quickshell"
        "swww-daemon"
        "systemctl --user start hyprpolkitagent"
        "hypridle"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      # --- Monitors ---
      monitor = [
        "DP-1,3440x1440@100,0x0,auto"
        "HDMI-A-1,1920x1080@100,3440x0,auto"
      ];

      # --- Input & Env ---
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "NIXOS_OZONE_WL,1"
      ];

      input = {
        kb_layout = "de";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
      };

      # --- Design System (Refactored) ---
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = true;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;
        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 5, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 5, default"
          "workspaces, 1, 5, default, slide"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # --- Rules ---
      windowrule = [
        # Polkit Agent (Muss floaten & Fokus haben)
        "float on, match:class hyprpolkitagent"
        "center on, match:class hyprpolkitagent"
        "dim_around on, match:class hyprpolkitagent"
        "stay_focused on, match:class hyprpolkitagent"

        # Standard Dialoge
        "float on, match:title (Open File)"
        "float on, match:title (Select a File)"
        "float on, match:title (Choose wallpaper)"
        "float on, match:title (Save As)"
        "float on, match:title (Library)"
        
        # Tools
        "float on, match:class vlc"
        "float on, match:class kvantummanager"
        "float on, match:class qt5ct"
        "float on, match:class qt6ct"
        "float on, match:class org.kde.ark"
        "float on, match:class com.github.rafostar.Clapper"

        # Steam
        # Friends List muss floaten
        "float on, match:title (Friends List)"
        "float on, match:title (Steam Settings)"
        
        # Gaming Performance
        "immediate on, match:class cs2"  # Tearing erlauben
      ];

      # --- Keybindings ---
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      
      bind = [
        "$mod, Q, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, $terminal -e yazi"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"
        "$mod, L, exec, hyprlock"
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        
        # Focus Movement
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        
        # Workspaces (1-10)
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Move to Workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];
      
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
