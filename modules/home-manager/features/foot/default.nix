{
  pkgs,
  config,
  lib,
  ...
}: let
  f = config.stylix.fonts;
in {
  programs = {
    foot = {
      enable = true;
      server.enable = false;
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
    zsh.initExtra = ". ${./zshrc} # enable shell integration for foot terminal";
  };

  home.packages = with pkgs; [libsixel];
}
