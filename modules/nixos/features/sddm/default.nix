# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  pkgs,
  lib,
  config,
  ...
}: let
  sddmTheme = import ./sddm-theme.nix {inherit pkgs;};
in {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = config.sharedOptions.isWayland;
    theme = "${sddmTheme}";
    settings = {
      Theme = {
        CursorTheme = config.stylix.cursor.name;
        CursorSize = config.stylix.cursor.size;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
  ];
}
