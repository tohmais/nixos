{
  inputs,
  outputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [outputs.homeManagerModules.default];

  myHomeManager = {
    bundles.gaming.enable = true;
    bundles.leisure.enable = true;
    bundles.university.enable = true;
    bundles.editing.enable = true;

    monitors = {
      "DP-2" = {
        width = 1920;
        height = 1080;
        refreshRate = 75.0;
        x = 0;
        y = 0;
      };
      "HDMI-A-1" = {
        width = 1920;
        height = 1080;
        refreshRate = 60.0;
        x = 1920;
        y = 0;
      };
    };
  };

  home = {
    username = "callum";
    homeDirectory = lib.mkDefault "/home/callum";
    stateVersion = "24.05";
  };
}
