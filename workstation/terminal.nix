{
  config,
  lib,
  ...
}: let
  f = config.hm.stylix.fonts;
in {
  hm = {
    home.sessionVariables = {
      "TERMINAL" = lib.mkDefault "foot";
    };

    programs.kitty.enable = true;

    programs.ghostty = {
      enable = true;
      settings = {
        window-decoration = false;
        gtk-single-instance = true;
      };
    };
  };
  programs.foot = {
    enable = true;
    settings = {
      main = {
        app-id = "foot";
        title = "foot";
        font = lib.mkForce "${f.monospace.name}:size=${toString f.sizes.terminal}, ${f.emoji.name}:size=${toString (f.sizes.terminal - 1.1)}";

        locked-title = "no";
      };
      tweak = {
        font-monospace-warn = "no";
      };
      cursor = {
        style = "beam";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
