{ pkgs, ... }:

{
  xdg.configFile."ghostty/config".text = ''
    # --- Window ---
    window-decoration = none
    window-padding-x = 10
    window-padding-y = 10
    
    # --- Behavior ---
    confirm-close-surface = false
    cursor-style = block
    shell-integration-features = no-cursor
    
    # --- Keybindings ---
    keybind = ctrl+shift+c=copy_to_clipboard
    keybind = ctrl+shift+v=paste_from_clipboard
  '';
}
