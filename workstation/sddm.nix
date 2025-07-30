# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  userPkgs,
  config,
  pkgs,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "tokyo-night";
    settings = {
      Theme = {
        CursorTheme = config.hm.stylix.cursor.name;
        CursorSize = config.hm.stylix.cursor.size;
      };
    };
  };

  environment.systemPackages = [(pkgs.callPackage userPkgs.sddm-tokyo-night {})];
}
