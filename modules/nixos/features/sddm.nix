# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  pkgs,
  lib,
  config,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = config.sharedOptions.isWayland;
    theme = "tokyo-night";
    settings = {
      Theme = {
        CursorTheme = config.stylix.cursor.name;
        CursorSize = config.stylix.cursor.size;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    sddm-tokyo-night
  ];
}
