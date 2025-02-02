{
  lib,
  config,
  ...
}: let
  f = config.stylix.fonts;
in {
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = lib.mkForce "${f.monospace.name}:size=${toString f.sizes.popups}";
        width = 50;
        dpi-aware = "no";
      };
    };
  };
}
