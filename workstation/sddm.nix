# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  pkgs,
  config,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = config.sharedOptions.isWayland;
    theme = "tokyo-night";
    settings = {
      Theme = {
        CursorTheme = config.hm.stylix.cursor.name;
        CursorSize = config.hm.stylix.cursor.size;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    sddm-tokyo-night
  ];
}
