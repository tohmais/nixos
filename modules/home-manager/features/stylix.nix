{
  pkgs,
  config,
  ...
}: {
  stylix = {
    iconTheme = {
      enable = true;
      package = pkgs.catppuccin-se-icons;
      dark = "Catppuccin-SE";
    };
    targets = {
      emacs.enable = false;
      spicetify.enable = true;
      qt.enable = true;
      hyprland.enable = false;
      hyprpaper.enable = false;
      nixcord.enable = true;
    };
  };
}
