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
        font = lib.mkForce "${f.monospace.name}:size=8";
        width = 50;
      };
    };
  };
}
