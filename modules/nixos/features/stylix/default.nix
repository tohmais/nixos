# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

    polarity = "dark";
    image = ./wallpaper.jpg;

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["Lilex"];};
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

    targets.grub.useImage = false;

    cursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 32;
    };
  };
  environment.systemPackages = [config.stylix.cursor.package];
}
