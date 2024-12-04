{ lib, pkgs, ... }: 
let
  icon-theme = import ./icon-theme.nix {inherit lib pkgs;};
in {
  stylix = {
    iconTheme = {
      enable = true;
      package = icon-theme;
      dark = "catppuccin-se";
    };
  };
}

