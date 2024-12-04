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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";
    image = ./wallpaper.jpg;

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font Mono";
      };
      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twemoji";
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
