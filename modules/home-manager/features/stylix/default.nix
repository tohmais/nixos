{ pkgs, ... }: 
let
  icon-theme = import ./icon-theme.nix {inherit pkgs;};
in {
  stylix = {
    iconTheme = {
      enable = true;
      package = icon-theme;
      dark = "catppuccin-se";
    };
    targets = {
      emacs.enable = true;
    };
  };
}

