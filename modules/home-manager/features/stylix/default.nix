{
  pkgs,
  config,
  ...
}: let
  icon-theme = import ./catppuccin-se.nix {inherit pkgs;};
in {
  stylix = {
    iconTheme = {
      enable = true;
      package = icon-theme;
      dark = "Catppuccin-SE";
    };
    targets = {
      emacs.enable = false;
      spicetify.enable = true;
      qt.enable = true;
    };
  };
}
