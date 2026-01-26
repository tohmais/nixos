{
  pkgs,
  inputs,
  config,
  mainUser,
  userPkgs,
  lib,
  ...
}: {
  hm = {
    imports = [inputs.stylix.homeModules.stylix];

    stylix = {
      enable = true;
      base16Scheme = ./kanagawa.yaml;

      polarity = "dark";
      image = lib.mkDefault ../../assets/wallhaven-y8e1vl.jpg;

      overlays.enable = false;

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.lilex;
          name = "Lilex Nerd Font Mono";
        };
        emoji = {
          package = pkgs.twitter-color-emoji;
          name = "Twitter Color Emoji";
        };
        sizes = {
          popups = 12;
        };
      };

      targets = {
        zen-browser.profileNames = [mainUser];
        emacs.enable = false;
        spicetify.enable = true;
        qt.enable = true;
        hyprland.enable = false;
        hyprpaper.enable = false;
        nixcord.enable = true;
      };

      cursor = {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors";
        size = 32;
      };

      icons = {
        enable = true;
        package = userPkgs.catppuccin-se-icon-theme;
        dark = "Catppuccin-SE";
      };
    };
  };
  environment.systemPackages = [config.hm.stylix.cursor.package];

  programs.dconf.enable = true;

  console.colors = with config.hm.lib.stylix.colors; [
    base00-hex
    red
    green
    yellow
    blue
    magenta
    cyan
    base05-hex
    base03-hex
    red
    green
    yellow
    blue
    magenta
    cyan
    base07-hex
  ];
}
