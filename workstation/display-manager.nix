# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  userPkgs,
  config,
  pkgs,
  lib,
  ...
}: {
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  #   theme = "tokyo-night";
  #   settings = {
  #     Theme = {
  #       CursorTheme = config.hm.stylix.cursor.name;
  #       CursorSize = config.hm.stylix.cursor.size;
  #     };
  #   };
  # };

  # environment.systemPackages = [(pkgs.callPackage userPkgs.sddm-tokyo-night {})];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --asterisks --remember --remember-session --user-menu --greeting \"Welcome to NixOS! Please authenticate below.\" --theme border=magenta;button=blue;prompt=blue";
        user = "greeter";
      };
      vt = 1;
    };
  };
}
