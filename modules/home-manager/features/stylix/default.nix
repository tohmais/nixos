{pkgs, config, ...}: let
  icon-theme = import ./icon-theme.nix {inherit pkgs;};
in {
  stylix = {
    iconTheme = {
      enable = true;
      package = icon-theme;
      dark = "Catppuccin-SE";
    };
    targets = {
      emacs.enable = false;
      hyprpaper.enable = false;
      hyprland.hyprpaper.enable = false;
    };
  };

  home.file = {
    ".local/share/icons/${config.stylix.iconTheme.dark}".source = "${icon-theme}";
  };
}
