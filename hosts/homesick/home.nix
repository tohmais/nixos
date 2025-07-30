{
  inputs,
  outputs,
  pkgs,
  lib,
  config,
  ...
}: {
  /*
     imports = [outputs.homeManagerModules.default];

  myHomeManager = {
    bundles.leisure.enable = true;
    bundles.university.enable = true;
    bundles.work.enable = true;

    monitors = {
      "eDP-1" = {
        width = 1920;
        height = 1080;
        refreshRate = 60.0;
        x = 0;
        y = 0;
        scale = 1.0;
      };
    };
  };
  */

  hm.home = {
    username = "callum";
    homeDirectory = lib.mkDefault "/home/callum";
    stateVersion = "24.11";
  };
}
