{
  pkgs,
  inputs,
  config,
  mainUser,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

    polarity = "dark";
    image = ../assets/wallhaven-y8e1vl.jpg;

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
      grub.useImage = false;
      plymouth.enable = false;
    };

    cursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 32;
    };
  };
  environment.systemPackages = [config.stylix.cursor.package];

  hm.stylix = {
    iconTheme = {
      enable = true;
      package = pkgs.catppuccin-se-icons;
      dark = "Catppuccin-SE";
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
  };
}