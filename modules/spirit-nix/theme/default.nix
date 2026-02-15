{ pkgs, ... }:

{
  # Stylix aktivieren
  stylix.enable = true;
  
  # 1. Das Hintergrundbild (Stylix generiert basierend darauf sogar Farben, wenn du willst)
  stylix.image = ./wallpaper.png;

  # 2. Die Base16 Farbpalette (Wir bleiben bei Catppuccin Mocha als Basis)
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

  # 3. Wir erzwingen den Dark-Mode
  stylix.polarity = "dark";

  # 4. Cursor global setzen
  stylix.cursor = {
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "catppuccin-mocha-mauve-cursors";
    size = 24;
  };

  # 5. Schriftarten global definieren
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    sansSerif = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
    };
    serif = {
      package = pkgs.noto-fonts;
      name = "Noto Serif";
    };
    sizes = {
      applications = 12;
      terminal = 13;
      desktop = 12;
    };
  };

  # 6. Deckkraft/Transparenz (Optional)
  stylix.opacity = {
    applications = 0.95;
    terminal = 0.90;
    desktop = 0.90; # Beeinflusst z.B. Waybar, falls unterstützt
  };
}
