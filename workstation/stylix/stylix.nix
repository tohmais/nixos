{
  pkgs,
  inputs,
  config,
  mainUser,
  userPkgs,
  ...
}: {
  hm = {
    imports = [inputs.stylix.homeModules.stylix];

    stylix = {
      enable = true;
      base16Scheme = ./kanagawa.yaml;

      polarity = "dark";
      image = ../../assets/wallhaven-y8e1vl.jpg;

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
        firefox.profileNames = [mainUser];
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

      iconTheme = {
        enable = true;
        package = pkgs.callPackage userPkgs.catppuccin-se-icon-theme {};
        dark = "Catppuccin-SE";
      };
    };
  };
  environment.systemPackages = [config.hm.stylix.cursor.package];

  programs.dconf.enable = true;
}
