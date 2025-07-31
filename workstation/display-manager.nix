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
        command = lib.concatStringsSep " " [
          (lib.getExe pkgs.greetd.tuigreet)
          "--time"
          "--asterisks"
          "--remember"
          "--remember-session"
          "--user-menu"
          "--greeting \"Welcome to NixOS! Please authenticate below.\""
          "--theme ${
            lib.concatStringsSep ";" [
              "border=magenta"
              "text=cyan"
              "prompt=green"
              "time=red"
              "action=blue"
              "button=yellow"
              "container=black"
              "input=red"
            ]
          }"
        ];
        user = "greeter";
      };
      vt = 1;
    };
  };
}
